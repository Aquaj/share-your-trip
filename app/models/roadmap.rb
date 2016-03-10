class Roadmap < ActiveRecord::Base
  belongs_to :user
  has_many :activities, dependent: :destroy
  has_many :experiences, through: :activities

  validates :user, presence: true

  def itinerary
    addresses = []
    scheduled = schedule

    addresses << start_destination unless start_destination.nil?

    scheduled.each do |day|
      %i(morning midday afternoon evening night).each do |part_of_day|
        day[part_of_day].each do |activity|
          addresses << activity.address
        end
      end
    end

    addresses << end_destination unless end_destination.nil?
  end

  def schedule
    SchedulerService.new.create_schedule(activities, start_date, end_date)
  end

end
