class Experience < ActiveRecord::Base
  belongs_to :user

  validates :type, presence: true
  validates :description, presence: true
  validates :address, presence: true
end
