class ItemsTableStartEndDateColumnType < ActiveRecord::Migration[6.0]
 

  def up 
    change_column(:items, :start_date, :timestamp)
    change_column(:items, :end_date, :timestamp)
  end

  def down 
    change_column(:items, :start_date, :date)
    change_column(:items, :end_date, :date)
  end
end
