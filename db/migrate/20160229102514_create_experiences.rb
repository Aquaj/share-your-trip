class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.references :user, index: true, foreign_key: true
      t.string :type
      t.text :description
      t.string :address

      t.timestamps null: false
    end
  end
end
