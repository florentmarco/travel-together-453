class AddTypeToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :type, :string
  end
end
