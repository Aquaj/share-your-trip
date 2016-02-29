class Wishlist < ActiveRecord::Base
  belongs_to :user
  belongs_to :experience

  validates :user_id, uniqueness: { scope: :experience_id }
end
