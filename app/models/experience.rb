require 'uri'

class Experience < ActiveRecord::Base
  belongs_to :user

  has_many :ratings, dependent: :destroy
  has_many :wishlists, dependent: :destroy
  has_many :users, through: :wishlists
  has_many :activities, dependent: :destroy
  has_many :roadmaps, through: :activities

  validates :title, presence: true
  validates :category, presence: true
  validates :category, inclusion: { in: %W(Amusement Panorama Visite Nature Musée Évènement Hôtel Restaurant Bar Vie\ Nocturne) }
  validates :description, presence: true
  validates :address, presence: true
  validates :photos, presence: true
  validate :valid_url

  has_attachments :photos, maximum: 3

  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  after_save :cache, if: :address_changed?

  def self.categories
    return %W(Amusement Panorama Visite Nature Musée Évènement Hôtel Restaurant Bar Vie\ Nocturne)
  end

  def self.search(search, experiences) # Second parameter needed to account for Pundit scope
    locate = LocationService.new
    if search && !search[:address].blank?
      city = locate.city(search[:address]) # if it's not city it's a country
      if city.present? # city
        experiences.near(search[:address], 20)
      else # country
        country = locate.country(search[:address])
        experiences.select{ |e| e.country == country}
      end
    else
      experiences
    end
  end

  def is_occupation?
    return !%W(Hôtel Restaurant Bar Vie\ Nocturne).include?(self.category)
  end

  # Not used (yet?)
  def is_reusable?
    return self.category == "Hôtel"
  end

  def average_rating
    if self.ratings.length > 0
      sum = self.ratings.reduce(0) { |a, r| r.rating+a }
      return sum/self.ratings.length
    else
      return 3 # Average by default not to penalize new Experiences
    end
  end

  ## City/Country/Continent
  # Returns the cached value of the property
  # if cache doesn't exist yet, builds cache
  # for all three values.
  def city
    cache if self.city_cache.nil?
    return city_cache
  end

  def country
    cache if self.country_cache.nil?
    return country_cache
  end

  def continent
    cache if self.continent_cache.nil?
    return continent_cache
  end

private

  def cache
    data = LocationService.new.full_info(address)
    update_columns(
      city_cache: data[:city],
      country_cache: data[:country],
      continent_cache: data[:continent]
    )
  end

  def valid_url
  return if self.url == nil
  uri = URI.parse(self.url)
  errors.add(:url, "n'est pas une URL valide.") unless uri.kind_of?(URI::HTTP)
  rescue URI::InvalidURIError
    errors.add(:url, "n'est pas une URL valide.")
  end
end
