class Experience < ActiveRecord::Base

  belongs_to :user

  has_many :ratings, dependent: :destroy
  has_many :wishlists, dependent: :destroy
  has_many :users, through: :wishlists

  validates :title, presence: true
  validates :category, presence: true
  validates :description, presence: true
  validates :address, presence: true
  validates :category, inclusion: { in: ["Bar", "Restaurant", "Leisure", "Sport", "Panorama", "Hotel"] }

  has_attachments :photos, maximum: 3

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  def self.categories
    return ["Bar", "Restaurant", "Leisure", "Sport", "Panorama", "Hotel"]
  end


  def self.search(search, experiences)
    if search
      experiences.near(search[:city], 20)
    else
      experiences
    end
  end
end
