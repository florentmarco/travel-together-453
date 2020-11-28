class Item < ApplicationRecord
  belongs_to :trip
  belongs_to :user
  has_many :comments
  has_many :votes
  has_many :tasks

  include PgSearch::Model
  pg_search_scope :search_by_status,
    against: [:status],
    using: {
      tsearch: { prefix: true }
  }

  pg_search_scope :search_by_category,
    against: [:category],
    using: {
      tsearch: { prefix: true }
  }

  pg_search_scope :search_by_id,
    against: [:trip_id],
    using: {
      tsearch: { prefix: true }
  }
end
