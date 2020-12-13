class FlightDetail < ApplicationRecord
  belongs_to :item

  validates :airline, presence: true
  validates :flight_number, presence: true
  validates :departure_airport, presence: true
  validates :arrival_airport, presence: true
  # validates :item_id, presence: true
end
