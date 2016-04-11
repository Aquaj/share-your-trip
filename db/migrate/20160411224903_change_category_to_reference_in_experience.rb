class ChangeCategoryToReferenceInExperience < ActiveRecord::Migration
  def change
    remove_column :experiences, :category
    add_reference :experiences, :category, index: true
  end
end
