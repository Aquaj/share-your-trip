class LocationService

  # Quasi-useless - Be Careful
  def city(address)
    full_info(address)[:city]
  end

  # Quasi-useless - Be Careful
  def country(address)
    nation = full_info(address)[:country]
  end

  # Quasi-useless - Be Careful
  def continent(address)
    full_info(address)[:continent]
  end

  # USE FULL_INFO EACH TIME YOU NEED MORE THAN ONE SINGLE COMPONENT
  def full_info(address)
    # Getting the info (1 query for all three)
    address_components = geocode(address)

    city = address_components.find { |ad| ad["types"].include? "locality" }
    city &&= city["long_name"] # &&= means "if it already exists"

    country = address_components.find{ |ad| ad["types"].include? "country"}

    continents = YAML.load(open("config/continents.yml")) # Loading from local YAML db
    continent = continents.find{|continent, data| data["countries"].include? country["short_name"]}[1]["name"]

    return { city: city, country: country["long_name"], continent: continent }
  end

private

  def geocode(address)
    debug_data = []
    10.times do # In case of a single exceptional malfunction
      sleep(0.2) # Avoids surcharge on the Geocoding API
      break if debug_data.present?
      debug_data = Geocoder.search(address)
    end
    raise StandardError, "GeocodingError." if debug_data.empty?
    # TODO: Check if exists (or create) a GeocodingError class
    debug_data[0].data["address_components"]
  end
end
