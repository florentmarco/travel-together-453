class DeleteChatroomModel < ActiveRecord::Migration[6.0]
  def change
    remove_reference :comments, :chatroom
    drop_table :chatrooms
  end

end
