class AddAddressCachingToRoadmap < ActiveRecord::Migration
  def change
    add_column :roadmaps, :start_city_cache, :string
    add_column :roadmaps, :start_country_cache, :string
    add_column :roadmaps, :start_continent_cache, :string
    add_column :roadmaps, :end_city_cache, :string
    add_column :roadmaps, :end_country_cache, :string
    add_column :roadmaps, :end_continent_cache, :string
  end
end
