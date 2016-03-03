class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.references :experience, index: true, foreign_key: true
      t.references :roadmap, index: true, foreign_key: true
      t.date :planned_on

      t.timestamps null: false
    end
  end
end
