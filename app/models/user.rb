class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :experiences
  has_many :wishlists
  has_many :wishlisted_experiences, through: :wishlists, source: :experiences

  validates :first_name, presence: true
  validates :last_name, presence: true
end
