class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.references :user, index: true, foreign_key: true
      t.references :experience, index: true, foreign_key: true
      t.integer :rating
      t.text :review

      t.timestamps null: false
    end
  end
end
