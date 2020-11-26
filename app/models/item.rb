class Item < ApplicationRecord
  belongs_to :trip
  belongs_to :user
  has_many :items
  has_many :comments
  has_many :votes
  has_many :tasks

  validates :type, inclusion: { in: %w(flights accomations activities) }
end
