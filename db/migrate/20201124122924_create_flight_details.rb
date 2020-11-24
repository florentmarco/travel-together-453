class CreateFlightDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :flight_details do |t|
      t.string :airline
      t.string :flight_number
      t.references :item
      t.string :departure_airport
      t.string :arrival_airport

      t.timestamps
    end
  end
end
