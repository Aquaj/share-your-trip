class AddAddressCachingToExperience < ActiveRecord::Migration
  def change
    add_column :experiences, :city_cache, :string
    add_column :experiences, :country_cache, :string
    add_column :experiences, :continent_cache, :string
  end
end
