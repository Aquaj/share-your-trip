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
  validates :category, inclusion: { in: %W(Amusement Panorama Visite Nature Musée Évènements Hôtel Restaurant Bar Vie\ Nocturne) }

  has_attachments :photos, maximum: 3

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  def self.categories
    return %W(Amusement Panorama Visite Nature Musée Évènements Hôtel Restaurant Bar Vie\ Nocturne)
  end

  def self.search(search, experiences) # Second parameter needed to account for Pundit scope
    locate = LocationService.new
    if search && !search[:address].blank?
      city = locate.city(address) # if it's not city it's a country
      if city.present? # city
        experiences.near(search[:address], 20)
      else # country
        experiences.select{ |e| e.country == locate.country(search[:address]) }
      end
    else
      experiences
    end
  end

  def is_occupation?
    return !%W(Hôtel Restaurant Bar Vie\ Nocturne).include?(self.category)
  end

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

  def city
    LocationService.new.city(address)
  end

  def country(short = false)
    LocationService.new.country(address)
  end

  def continent
    LocationService.new.continent(address)
  end
end
