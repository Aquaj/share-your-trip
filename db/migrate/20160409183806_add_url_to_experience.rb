class AddUrlToExperience < ActiveRecord::Migration
  def change
    add_column :experiences, :url, :string
  end
end
