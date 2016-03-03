class Activity < ActiveRecord::Base
  belongs_to :experience
  belongs_to :roadmap

  validates :experience, presence: true
  validates :roadmap, presence: true
end
