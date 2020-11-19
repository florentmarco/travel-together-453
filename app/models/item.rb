class Item < ApplicationRecord
  belongs_to :trip
  belongs_to :task
end
