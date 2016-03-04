class CreateRoadmaps < ActiveRecord::Migration
  def change
    create_table :roadmaps do |t|
      t.references :user, index: true, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.string :start_destination
      t.string :end_destination
      t.integer :travellers_num

      t.timestamps null: false
    end
  end
end
