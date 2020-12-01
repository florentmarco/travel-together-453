class Item < ApplicationRecord
  belongs_to :trip
  belongs_to :user
  has_many :comments
  has_many :votes
  has_many :tasks

  has_many :flight_details

  validates :category, inclusion: { in: %w(flight accomodation activity) }

  include PgSearch::Model
  pg_search_scope :search_by_status,
    against: [:status],
    using: {
      tsearch: { any_word: true }
  }

  pg_search_scope :search_by_category,
    against: [:category],
    using: {
      tsearch: { any_word: true }
  }

  pg_search_scope :search_by_id,
    against: [:trip_id],
    using: {
      tsearch: { prefix: true }
  }

end
