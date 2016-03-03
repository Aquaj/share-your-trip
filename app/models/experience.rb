class Experience < ActiveRecord::Base
  belongs_to :user

  has_many :ratings, dependent: :destroy
  has_many :wishlists, dependent: :destroy
  has_many :users, through: :wishlists

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
    return ["Bar", "Restaurant", "Leisure", "Sport", "Panorama", "Hotel"]
  end

  def officialize_country
    self.country =  Geocoder.search(self.country).first.formatted_address
  end


  def self.search(search, experiences)
    if !search[:address].blank?
      if Geocoder.search(search[:address]).first.types.include? "country"
        experiences.where(country: Geocoder.search(search[:address]).first.formatted_address)
      else
        experiences.near(search[:address], 20)
      end
    else
      experiences
    end
  end
end
