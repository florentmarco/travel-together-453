class Notification < ApplicationRecord
  belongs_to :trip
  belongs_to :user

  scope :unread, -> { where(read_at: nil) }
end
