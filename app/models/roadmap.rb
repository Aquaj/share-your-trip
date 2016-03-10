class Roadmap < ActiveRecord::Base
  belongs_to :user
  has_many :activities, dependent: :destroy
  has_many :experiences, through: :activities

  validates :user, presence: true

  after_validation :cache_start_components, if: :start_destination_changed?
  after_validation :cache_end_components, if: :end_destination_changed?

  def itinerary
    addresses = []
    scheduled = schedule

    addresses << start_city unless start_destination.nil?

    scheduled.each do |day|
      %i(morning midday afternoon evening night).each do |part_of_day|
        day[part_of_day].each do |activity|
          addresses << activity.city
        end
      end
    end

    addresses << end_city unless end_destination.nil?
    addresses.chunk{|x| x}.map(&:first)
  end

  def schedule
    SchedulerService.new.create_schedule(activities, start_date, end_date)
  end

  # TODO: Metaprog all those away.
  def start_city
    cache_start_components if self.start_city_cache.nil?
    return start_city_cache
  end

  def start_country
    cache_start_components if self.start_country_cache.nil?
    return start_country_cache
  end

  def start_continent
    cache_start_components if self.start_continent_cache.nil?
    return start_continent_cache
  end

  def end_city
    cache_end_components if self.end_city_cache.nil?
    return end_city_cache
  end

  def end_country
    cache_end_components if self.end_country_cache.nil?
    return end_country_cache
  end

  def end_continent
    cache_end_components if self.end_continent_cache.nil?
    return end_continent_cache
  end

private

  def cache_start_components
    if start_destination.nil?
      update(
          start_city_cache: nil,
          start_country_cache: nil,
          start_continent_cache: nil
        )
    end
    start_components = LocationService.new.full_info(start_destination) unless start_destination.nil?
    if start_destination.present?
      update(
        start_city_cache: start_components[:city],
        start_country_cache: start_components[:country],
        start_continent_cache: start_components[:continent]
      )
    end
  end

  def cache_end_components
    if start_destination.nil?
      update(
          start_city_cache: nil,
          start_country_cache: nil,
          start_continent_cache: nil
        )
    end
    end_components = LocationService.new.full_info(end_destination) unless end_destination.nil?
    if end_destination.present?
      update(
        end_city_cache: end_components[:city],
        end_country_cache: end_components[:country],
        end_continent_cache: end_components[:continent]
      )
    end
  end
end
