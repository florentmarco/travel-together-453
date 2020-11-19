class Item < ApplicationRecord
  belongs_to :trip
  belongs_to :task
  has_many :votes
  has_many :comments
end
