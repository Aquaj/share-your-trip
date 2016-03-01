class Experience < ActiveRecord::Base

  belongs_to :user

  has_many :ratings, dependent: :destroy
  has_many :wishlists, dependent: :destroy
  has_many :users, through: :wishlists

  validates :title, presence: true
  validates :category, presence: true
  validates :description, presence: true
  validates :address, presence: true
  validates :category, inclusion: { in: ["Bar", "Restaurant", "Leisure", "Sport", "Panorama"] }
  has_attachments :photos, maximum: 3
  def self.categories
    return ["Bar", "Restaurant", "Leisure", "Sport", "Panorama"]
  end


  def self.search(search)
    if search
      all.where('address LIKE ?', "%#{search}%")
    else
      all
    end
  end
end
