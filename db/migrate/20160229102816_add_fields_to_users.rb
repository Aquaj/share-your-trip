class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :status, :string
    add_column :users, :luggage, :string
    add_column :users, :local_mobility, :string
    add_column :users, :travel_type, :string
    add_column :users, :accomodation_type, :string
  end
end
