class PlannerService

  def plan_for(activities, start_city=nil, start_date=nil, end_city=nil, end_date=nil)
    schedule = create_schedule(activities, start_date, end_date)
    return {
      schedule: schedule,
      itinerary: itinerary(schedule, activities.select{|a|a.planned_on.nil?}, start_city, end_city)
    }
  end

private

  # Lists the cities the traveller is gonna go through in the order
  # they will cross them from a Schedule
  def itinerary(schedule, unplanned, start_city, end_city)
    itinerary_stops = []

    itinerary_stops << start_city unless start_city.nil?

    schedule.each do |day|
      # For every day on the schedule
      %i(morning midday afternoon evening night).each do |part_of_day|
        day[part_of_day].each do |activity|
          # Add the city of the activities the user
          # has planned to our itinerary
          itinerary_stops << activity.city
        end
      end
    end

    itinerary_stops << end_city unless end_city.nil?

    itinerary_stops.chunk{|x| x}.map(&:first)
    # Removes consecutive duplicates
    # Ex: [Paris Bordeaux Bordeaux Nantes Paris Paris]
    # becomes : [Paris Bordeaux Nantes Paris]
  end

  def create_schedule(activities, start_date=nil, end_date=nil)

    # Not making the service really stateful.
    # Just sparing myself parameters on every private method call.
    @activities = activities.freeze
    @start_date = start_date.freeze
    @end_date = end_date.freeze

    # Day activities are stocked in an Array even if there's only one for two reasons :
    #   - Extendability/Modification
    #   - So they can all be consulted the same way (iteration) instead of coding another method
    planning = Array.new(duration) do |day_index|
      {
        morning: [],
        midday: [],
        afternoon: [],
        evening: [],
        night: [],
        unscheduled: unscheduled_activities(day_index)
      }
    end
    planning.each do |day|
      # Splitting for easier work : (+ Shuffling for randomization)
      #  -- All occupations
      occupations = day[:unscheduled].select(&:is_occupation?).shuffle

      #  -- Everything non-occupational :
      #     -- Restaurants
      restaurants = day[:unscheduled].select { |poi| poi.category == "Restaurant" }.shuffle

      #     -- Bars
      bars = day[:unscheduled].select { |poi| poi.category == "Bar" }.shuffle

      #     -- Hotels
      hotels = day[:unscheduled].select { |poi| poi.category == "Hotel" }.shuffle

      #     -- Nightlife
      nightlife = day[:unscheduled].select { |poi| poi.category == "Vie nocturne" }.shuffle

      # Initializing the Hash that'll keep track of what couldn't fit.
      unscheduled = {occupations: [], bars: [], restaurants: [], hotels: [], nightlife: []}


      if occupations.length < 2
        # Afternoon prioritized
        day[:afternoon] << occupations.first if occupations.first.present?
      elsif occupations.length == 2
        # 1 activity / half-day
        day[:afternoon] << occupations[0]
        day[:morning] << occupations[1]
      else
        # Afternoon prioritized
        day[:afternoon] += occupations.first(2)
        day[:morning] += occupations.last(2 % occupations.length)

        unscheduled[:occupations] = occupations[2...-2] # Leftovers if any
      end

      if restaurants.length < 2
        # Evening prioritized
        day[:evening] << restaurants.first if restaurants.first.present?
      elsif restaurants.length == 2
        # 1 restaurant for lunch / 1 for the evening
        day[:evening] << restaurants[0]
        day[:midday] << restaurants[1]
      else
        # Evening prioritized
        day[:evening] += restaurants.first(2) # Afternoon prioritized
        day[:midday] += restaurants.last(2 % restaurants.length)
        unscheduled[:restaurants] = restaurants[2...-2] # Leftovers
      end

      day[:evening] << bars[0] if bars.present?
      unscheduled[:bars] = bars.empty? ? [] : bars[1..-1]

      day[:night] << nightlife[0] if nightlife.present?
      unscheduled[:nightlife] = nightlife.empty? ? [] : nightlife[1..-1]

      day[:night] << hotels[0] if hotels.present?
      unscheduled[:hotels] = hotels.empty? ? [] : hotels[1..-1]

      day[:unscheduled] = unscheduled
    end

    planning
  end

  # Beginning is either the start_date or
  # the date of the first planned activity
  def beginning
    return @start_date unless @start_date.nil?
    return activity_dates[0] if planned_activities.present?
    return nil
  end

  # Finish is either the end_date or
  # the date of the last planned activity
  def finish
    return @end_date unless @end_date.nil?
    return activity_dates[-1] if planned_activities.present?
    return nil
  end

  def planned_activities
    @activities.select { |activity| activity.planned_on.present? }
  end

  # "Unplanned" = Not planned
  def unplanned_activities
    @activities.select { |activities| activity.planned_on.nil? }
  end

  def activity_dates # Sorted
    planned_activities.map(&:planned_on).sort
  end

  def duration
    if beginning.present? && finish.present? && (beginning != finish)
      return finish - beginning - 1
      # -1 cause you don't travel on the days of your flights
    else
      return 7 # Current default.
      # TODO: Implement Weekend / Week / Month long choices for trips.
    end
  end

  # All activities for a given day before scheduling
  def unscheduled_activities(day_index)
    return [] unless beginning.present?
    return planned_activities.select{ |activity| activity.planned_on == (beginning + day_index)}
    # Could be done with self.activities for performance, overruled for code clarity
  end
end
