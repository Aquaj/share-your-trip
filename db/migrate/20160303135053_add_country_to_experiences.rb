class AddCountryToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :country, :string
  end
end
