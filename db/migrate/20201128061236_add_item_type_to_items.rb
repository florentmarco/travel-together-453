class AddItemTypeToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :item_type, :string
  end
end
