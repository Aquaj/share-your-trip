class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :experiences, dependent: :destroy
  has_many :wishlists, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :wishlisted_experiences, through: :wishlists, source: :experience

  validates :first_name, presence: true
  validates :last_name, presence: true
end
