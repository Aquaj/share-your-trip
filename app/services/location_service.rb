class LocationService

  def city(address)
    locality = geocode(address).find { |ad| ad["types"].include? "locality" }
    if locality.present?
      return locality["long_name"]
    else
      return nil
    end
  end

  def country(address, short=false)
    nation = geocode(address).find{ |ad| ad["types"].include? "country"}
    if short
      return nation["short_name"]
    else
      return nation["long_name"]
    end
  end

  def continent(address)
    continents = YAML.load(open("config/continents.yml"))
    continents.find{|continent, data| data["countries"].include? country(address, short=true)}[1]["name"]
  end

private

  def geocode(address)
    debug_city = []
    10.times do
      sleep(0.2)
      debug_city = Geocoder.search(address) unless debug_city.present?
    end
    raise StandardError, "Geocoding fucked up." if debug_city.empty?
    debug_city[0].data["address_components"]
  end
end
