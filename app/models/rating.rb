class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :experience

  validates :rating, presence: true
  validates :rating, numericality: { greater_than: 0, less_than_or_equal_to: 5 }
  validates :user_id, uniqueness: { scope: :experience_id }
end
