Date::DATE_FORMATS[:fr_date] = ->(date) { date.strftime("#{date.day}/#{date.month}/#{date.year}") }
