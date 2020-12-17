class NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_notifications

  def index
    @notifications = policy_scope(Notification).where(recipient: current_user).where(read_at: nil)
  end

  def mark_as_read
    @notifications = policy_scope(Notification).where(recipient: current_user).where(read_at: nil)
    @notifications.update_all(read_at: Time.zone.now)
    render json: {success: true}
  end

  private

  def set_notifications
    @notifications = Notification.where(recipient: current_user, read_at: nil).to_a
  end
end
