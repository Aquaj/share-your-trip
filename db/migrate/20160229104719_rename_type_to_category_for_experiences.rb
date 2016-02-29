class RenameTypeToCategoryForExperiences < ActiveRecord::Migration
  def change
    rename_column :experiences, :type, :category
  end
end
