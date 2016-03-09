class Experience < ActiveRecord::Base
  belongs_to :user

  has_many :ratings, dependent: :destroy
  has_many :wishlists, dependent: :destroy
  has_many :users, through: :wishlists
  has_many :activities, dependent: :destroy
  has_many :roadmaps, through: :activities

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  validates :title, presence: true
  validates :category, presence: true
  validates :description, presence: true
  validates :address, presence: true
  validates :country, presence: true
  validates :category, inclusion: { in: ["Bar", "Restaurant", "Leisure", "Sport", "Panorama", "Hotel"] }

  has_attachments :photos, maximum: 3

  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  after_validation :officialize_country

  def self.categories
    return %w(Amusement Panorama Visite Nature Musée Évènements Hôtel Restaurant Bar)
  end

  def is_occupation?
    return !%w(Hôtel Restaurant Bar).include?(self.category)
  end

  def is_reusable?
    return self.category == "Hôtel"
  end

  def officialize_country
    self.country =  Geocoder.search(self.country).first.formatted_address
  end

  def average_rating
    if self.ratings.length > 0
      sum = self.ratings.reduce(0) { |a, r| r.rating+a }
      return sum/self.ratings.length
    else
      return 3
    end
  end

  def self.search(search, experiences)
    if search && !search[:address].blank?
      if Geocoder.search(search[:address]).first.types.include? "country"
        experiences.where(country: Geocoder.search(search[:address]).first.formatted_address)
      else
        experiences.near(search[:address], 20)
      end
    else
      experiences
    end
  end

  def city
    debug_city = []
    while debug_city == [] do
      debug_city = Geocoder.search(address)
    end
    city_data = debug_city[0].data["address_components"].select{|a| a["types"].include? "locality"}
    if city_data.length > 0
      return city_data[0]["long_name"]
    else
      return nil
    end
  end

  def country(short = false)
    debug_country = []
    # Accounting for attribute/method homonym-ness
    dest = self.attributes["country"].present? ? self.attributes["country"] : address
    while debug_country == [] do
      debug_country = Geocoder.search(dest)
    end
    components = debug_country[0].data["address_components"].find{|comp| comp["types"].include? "country"}
    if short
      return components["short_name"]
    else
      return components["long_name"]
    end
  end

  def continent
    continents = YAML.load(open("config/continents.yml"))
    continents.find{|continent, data| data["countries"].include? country(short=true)}[1]["name"]
  end
end
