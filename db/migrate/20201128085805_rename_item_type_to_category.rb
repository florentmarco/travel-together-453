class RenameItemTypeToCategory < ActiveRecord::Migration[6.0]
  def change
    rename_column :items, :type, :category
  end
end
