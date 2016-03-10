class Roadmap < ActiveRecord::Base
  belongs_to :user
  has_many :activities, dependent: :destroy
  has_many :experiences, through: :activities

  validates :user, presence: true

  after_validation :cache_start_components, if: :start_destination_changed?
  after_validation :cache_end_components, if: :end_destination_changed?

  def planning
    PlannerService.new.plan_for(activities, start_city, start_date, end_city, end_date)
  end

  ## Explanation of functions below :
  # When someone asks for the data (city/country/continent)
  # we return the cached value.
  # If cache is empty, we compute and cache all 3 components
  # values for future use.
  # Repeat for all 3 components for both start and end

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
    if start_destination.nil? # Case: removal of start_destination
      update(
          start_city_cache: nil,
          start_country_cache: nil,
          start_continent_cache: nil
        )
    else # Case: update of start_destination
      start_components = LocationService.new.full_info(start_destination)
      update(
        start_city_cache: start_components[:city],
        start_country_cache: start_components[:country],
        start_continent_cache: start_components[:continent]
      )
    end
  end

  # TODO: Metaprog all those away.
  def cache_end_components
    if end_destination.nil? # Case: removal of end_destination
      update(
          end_city_cache: nil,
          end_country_cache: nil,
          end_continent_cache: nil
        )
    else # Case: update of end_destination
      end_components = LocationService.new.full_info(end_destination)
      update(
        end_city_cache: end_components[:city],
        end_country_cache: end_components[:country],
        end_continent_cache: end_components[:continent]
      )
    end
  end
end
