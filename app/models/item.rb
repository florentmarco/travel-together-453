class Item < ApplicationRecord
  belongs_to :trip
  belongs_to :user
  has_many :comments
  has_many :votes, dependent: :destroy
  has_many :tasks

  has_one :flight_detail

  validates :category, inclusion: { in: %w(Flight Accommodation Activity) }
  validates :start_date, presence: true
  # validates :end_date, presence: true

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

  # .where returns a collection
  def voted_by?(user)
    votes.where(user_id: user.id).exists?
  end

  def selected_vote(user)
    votes.where(user_id: user.id).first
  end
end
