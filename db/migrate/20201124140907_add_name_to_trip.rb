class AddNameToTrip < ActiveRecord::Migration[6.0]
  def change
    add_column :trips, :name, :string
  end
end
