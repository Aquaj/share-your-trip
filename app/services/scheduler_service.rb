class SchedulerService
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
      unscheduled[:bars] = bars[1..-1] # Leftovers

      day[:night] << hotels[0] if hotels.present?
      unscheduled[:hotels] = hotels.empty? ? [] : hotels[1..-1]

      day[:night] << nightlife[0] if nightlife.present?
      unscheduled[:nightlife] = nightlife.empty? ? [] : nightlife[1..-1]

      day[:unscheduled] = unscheduled
    end

    planning
  end

private

  def beginning
    return @start_date unless @start_date.nil?
    return activity_dates[0] if planned_activities.present?
    return nil
  end

  def finish
    return @end_date unless @end_date.nil?
    return activity_dates[-1] if planned_activities.present?
    return nil
  end

  def planned_activities
    @activities.select { |activity| activity.planned_on.present? }
  end

  def unplanned_activities
    @activities.select { |activities| activity.planned_on.nil? }
  end

  def activity_dates # Sorted
    planned_activities.map(&:planned_on).sort
  end

  def duration
    if beginning.present? && finish.present?
      return finish - beginning - 1
      # -1 cause you don't travel on the day of your flight
    else
      return 7 # Current default.
      # TODO: Implement Weekend / Week / Month long choices for trips.
    end
  end

  def unscheduled_activities(day_index)
    return [] unless beginning.present?
    return planned_activities.select{ |activity| activity.planned_on == (beginning + day_index)}
    # Could be done with self.activities for performance, overruled for code clarity
  end
end
