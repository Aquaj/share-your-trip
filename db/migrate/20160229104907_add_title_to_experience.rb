class AddTitleToExperience < ActiveRecord::Migration
  def change
    add_column :experiences, :title, :string
  end
end
