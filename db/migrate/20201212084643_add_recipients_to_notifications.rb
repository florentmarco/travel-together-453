class AddRecipientsToNotifications < ActiveRecord::Migration[6.0]
  def change
    add_reference :notifications, :recipient, null: false, foreign_key: { to_table: :users }
  end
end
