class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.references :trip, null: false, foreign_key: true
      t.references :task, null: false, foreign_key: true
      t.string :name
      t.string :category
      t.date :start_date
      t.date :end_date
      t.boolean :confirmed
      t.string :address
      t.integer :price
      t.string :url
      t.string :airline
      t.string :airport
      t.string :flight_number
      t.time :time

      t.timestamps
    end
  end
end
