class Item < ApplicationRecord
  belongs_to :trip
  belongs_to :user
  has_many :items
  has_many :comments
  has_many :votes
  has_many :tasks
  has_many :flight_details

  validates :category, inclusion: { in: %w(flight accomodation activity) }
end
