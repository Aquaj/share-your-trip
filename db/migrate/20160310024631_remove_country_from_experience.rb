class RemoveCountryFromExperience < ActiveRecord::Migration
  def change
    remove_column :experiences, :country
  end
end
