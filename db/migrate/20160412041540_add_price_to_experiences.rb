class AddPriceToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :price, :integer
  end
end
