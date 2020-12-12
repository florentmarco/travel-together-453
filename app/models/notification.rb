class Notification < ApplicationRecord
  belongs_to :trip
  belongs_to :user
  belongs_to :recipient, class_name: "User", optional: true
  belongs_to :message, optional: true

  scope :unread, -> { where(read_at: nil) }
end
