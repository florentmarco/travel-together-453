class Message < ApplicationRecord
  belongs_to :chatroom
  belongs_to :user

  after_create :create_notifications

  def create_notifications
    Notification.create(trip_id: trip_id, user_id: user)
  end
end
