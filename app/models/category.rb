class Category < ActiveRecord::Base
  belongs_to :parent_category, class_name: 'Category', foreign_key: :category_id
  has_many :sub_categories, class_name: 'Category', foreign_key: :category_id

  validates :title, presence: true

  def with_children
    [self, self.sub_categories].flatten
  end

  def is_root?
    parent_category.nil?
  end

  def self.roots
    all
      .select { |c| c.parent_category.nil? }
  end

  def self.as_tree
    roots
      .map    { |c| c.with_children }
      .flatten
    # Should ensure we always have them in the right order.
  end
end
