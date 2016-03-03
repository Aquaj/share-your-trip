class Experience < ActiveRecord::Base

  belongs_to :user

  has_many :ratings, dependent: :destroy
  has_many :wishlists, dependent: :destroy
  has_many :users, through: :wishlists

  validates :title, presence: true
  validates :category, presence: true
  validates :description, presence: true
  validates :address, presence: true
  validates :country, presence: true
  validates :category, inclusion: { in: ["Bar", "Restaurant", "Leisure", "Sport", "Panorama", "Hotel"] }

  has_attachments :photos, maximum: 3

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  def self.categories
    return ["Bar", "Restaurant", "Leisure", "Sport", "Panorama", "Hotel"]
  end


  def self.search(search, experiences)
    if search
      if Geocoder.search(search[:address]).first.types.include? "country"
        experiences.where(country: search[:address])
      else
        experiences.near(search[:address], 20)
      end
    else
      experiences
    end
  end
end
