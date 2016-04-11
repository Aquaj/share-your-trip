class Category < ActiveRecord::Base
  belongs_to :parent_category, class_name: 'Category', foreign_key: :category_id
  has_many :sub_categories, class_name: 'Category', foreign_key: :category_id

  validates :title, presence: true
end
