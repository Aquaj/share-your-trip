class LocationService

  def city(address)
    full_info(address)[:city]
  end

  def country(address)
    nation = full_info(address)[:country]
  end

  def continent(address)
    full_info(address)[:continent]
  end

  # USE FULL_INFO EACH TIME YOU NEED MORE THAN ONE SINGLE COMPONENT
  def full_info(address)
    address_components = geocode(address)
    city = address_components.find { |ad| ad["types"].include? "locality" }
    city &&= city["long_name"]
    country = address_components.find{ |ad| ad["types"].include? "country"}
    continents = YAML.load(open("config/continents.yml"))
    continent = continents.find{|continent, data| data["countries"].include? country["short_name"]}[1]["name"]
    return { city: city, country: country["long_name"], continent: continent }
  end

private

  def geocode(address)
    debug_city = []
    10.times do
      sleep(0.2)
      break if debug_city.present?
      debug_city = Geocoder.search(address)
    end
    raise StandardError, "GeocodingError." if debug_city.empty?
    debug_city[0].data["address_components"]
  end
end
