class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :experience

  validates :rating, presence: true
  validates :user_id, uniqueness: { scope: :experience_id }
end
