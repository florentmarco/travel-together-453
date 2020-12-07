class DeleteColumnTypeForItems < ActiveRecord::Migration[6.0]
  def change
    remove_column :items, :type
  end
end
