class RemoveTravellerNumFromRoadmap < ActiveRecord::Migration
  def change
    remove_column :roadmaps, :travellers_num
  end
end
