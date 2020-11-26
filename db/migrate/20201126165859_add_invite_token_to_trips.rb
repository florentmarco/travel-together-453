class AddInviteTokenToTrips < ActiveRecord::Migration[6.0]
  def change
    add_column :trips, :invite_token, :string
  end
end
