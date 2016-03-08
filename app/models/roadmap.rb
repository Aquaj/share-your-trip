class Roadmap < ActiveRecord::Base
  belongs_to :user
  has_many :activities, dependent: :destroy
  has_many :experiences, through: :activities

  validates :user, presence: true

  def title
    title = "Mon voyage "

    addresses = self.activities.map(&:experience).map(&:address)

    r_start = self.start_destination
    r_end = self.end_destination

    addresses << r_start if r_start.present?
    addresses << r_end if r_end.present?

    cities = addresses.map { |address| city(address) }
    if cities.uniq.length == 1
      title += "à " + cities.uniq[0]
      # in City (if everything happens in same city)
    else
      countries = addresses.map { |address| country(address) }
      if countries.uniq.length == 1
        title += "en " + country(r_start)
        # in Country (if everything happens in same country)
      else
        continents = addresses.map { |address| continent(address) }
        if continents.uniq.length == 1
          title += "en " + continent(r_start)
          # in Continent (if everything happens in same continent)
        elsif continents.uniq.length == 2
          title += " #{continents.uniq[0]} - #{continents.uniq[1]}"
          # around the world (if trip is across continents)
        else
          title += " autour du globe"
        end
      end
    end

  end

  private

  def city(destination)
    debug_city = Geocoder.search(destination)
    city_data = debug_city[0].data["address_components"].select{|a| a["types"].include? "locality"}
    if city_data.length > 0
      return city_data[0]["long_name"]
    else
      return nil
    end
  end

  def country(destination, short = false)
    debug_country = Geocoder.search(destination)
    components = debug_country[0].data["address_components"].find{|comp| comp["types"].include? "country"}
    if short
      return components["short_name"]
    else
      return components["long_name"]
    end
  end

  def continent(destination)
    continents = YAML.load(open("config/continents.yml"))
    continents.find{|continent, data| data["countries"].include? country(destination, short=true)}[1]["name"]
  end
end
