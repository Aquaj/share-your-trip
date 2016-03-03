class Roadmap < ActiveRecord::Base
  belongs_to :user
  has_many :activities, dependent: :destroy
  has_many :experiences, through: :activities
end
