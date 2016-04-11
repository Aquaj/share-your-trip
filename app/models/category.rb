class Category < ActiveRecord::Base
  belongs_to :parent_category, class_name: 'Category', foreign_key: :category_id
  has_many :sub_categories, class_name: 'Category', foreign_key: :category_id

  validates :title, presence: true

  def self.as_tree
    all
      .select { |c| c.parent_category.nil? }
      .map    { |c| [c, c.sub_categories.flatten ]}
      .flatten
    # Should ensure we always have them in the right order.
  end
end
