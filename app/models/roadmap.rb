class Roadmap < ActiveRecord::Base
  belongs_to :user
  has_many :activities, dependent: :destroy
  has_many :experiences, through: :activities

  validates :user, presence: true

  validate :start_date_is_a_date_or_nil
  validate :end_date_is_a_date_or_nil
  validate :start_date_is_valid
  validate :end_date_is_valid

  after_save :cache_start_components, if: :start_destination_changed?
  after_save :cache_end_components, if: :end_destination_changed?

  def planning
    case self.details[:kind]
    when :city
      function = :address
    when :country
      function = :city
    else
      function = :city
    end

    start_ = send("start_#{function}")
    end_ = send("end_#{function}")
    PlannerService.new.plan_for(activities, start_, start_date, end_, end_date, self.details[:kind])
  end

  def details
    # Traded in sliiiiight amount of performance/memory
    # to decrease significantly Geocoding queries.
    cities = []
    countries = []
    continents = []

    unless self.start_destination.nil?
      cities << self.start_city
      countries << self.start_country
      continents << self.start_continent
    end

    unless self.end_destination.nil?
      cities << self.end_city
      countries << self.end_country
      continents << self.end_continent
    end

    # in City (if everything happens in same city)
    cities += self.activities.map(&:city)
    return {kind: :city, where: cities.first} if cities.uniq.length == 1

    # in Country (if everything happends in same country)
    countries += self.activities.map(&:country)
    return {kind: :country, where: countries.first} if countries.uniq.length == 1

    continents += self.activities.map(&:continent)
    continents.uniq!

    return {kind: :continent, where: continents.first} if continents.length == 1
    return {kind: :bicontinent, where: "#{continents.first} - #{continents.last}"} if continents.length == 2
    return {kind: :global}
  end

  ## Explanation of functions below :
  # When someone asks for the data (city/country/continent)
  # we return the cached value.
  # If cache is empty, we compute and cache all 3 components
  # values for future use.
  # Repeat for all 3 components for both start and end

  def start_address
    start_destination
  end

  # TODO: Metaprog all those away.
  def start_city
    cache_start_components if (start_city_cache.nil? && start_destination.present?)
    return start_city_cache
  end

  # TODO: Metaprog all those away.
  def start_country
    cache_start_components if (start_country_cache.nil? && start_destination.present?)
    return start_country_cache
  end

  def end_address
    end_destination
  end

  # TODO: Metaprog all those away.
  def start_continent
    cache_start_components if (start_continent_cache.nil? && start_destination.present?)
    return start_continent_cache
  end

  # TODO: Metaprog all those away.
  def end_city
    cache_end_components if (end_city_cache.nil? && end_destination.present?)
    return end_city_cache
  end

  # TODO: Metaprog all those away.
  def end_country
    cache_end_components if (end_country_cache.nil? && end_destination.present?)
    return end_country_cache
  end

  # TODO: Metaprog all those away.
  def end_continent
    cache_end_components if (end_continent_cache.nil? && end_destination.present?)
    return end_continent_cache
  end

private

  # TODO: Metaprog all those away.
  def cache_start_components
    if start_destination.empty? # Case: removal of start_destination
      update_columns(
          start_city_cache: nil,
          start_country_cache: nil,
          start_continent_cache: nil
        )
    else # Case: update of start_destination
      start_components = LocationService.new.full_info(start_destination)
      update_columns(
        start_city_cache: start_components[:city],
        start_country_cache: start_components[:country],
        start_continent_cache: start_components[:continent]
      )
    end
  end

  # TODO: Metaprog all those away.
  def cache_end_components
    if end_destination.empty? # Case: removal of end_destination
      update_columns(
          end_city_cache: nil,
          end_country_cache: nil,
          end_continent_cache: nil
        )
    else # Case: update of end_destination
      end_components = LocationService.new.full_info(end_destination)
      update_columns(
        end_city_cache: end_components[:city],
        end_country_cache: end_components[:country],
        end_continent_cache: end_components[:continent]
      )
    end
  end

  ### Validators ###

  def start_date_is_a_date_or_nil
    if start_date.present?
      if ![Date, DateTime].include? start_date.class
        errors.add(:start_date, "n'est pas une date valide.")
      end
    end
  end

  def end_date_is_a_date_or_nil
    if end_date.present?
      if ![Date, DateTime].include? end_date.class
        errors.add(:end_date, "n'est pas une date valide.")
      end
    end
  end

  def start_date_is_valid
    if start_date.present?
      if start_date < updated_at
        errors.add(:start_date, "ne peut pas être antérieure à aujourd'hui")
      end
    end
  end

  def end_date_is_valid
    if start_date.present?
      if end_date.present?
        if end_date < start_date
          errors.add(:start_date, "ne peut pas être antérieure à la date de départ")
        end
      end
    end
  end
end
