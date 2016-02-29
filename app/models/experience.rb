class Experience < ActiveRecord::Base
  belongs_to :user

  has_many :reviews, dependent: :destroy
  has_many :wishlists, dependent: :destroy
  has_many :users, through: :wishlists

  validates :title, presence: true
  validates :category, presence: true
  validates :description, presence: true
  validates :address, presence: true
end
