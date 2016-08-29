class RenameSenderId < ActiveRecord::Migration
  def change
    rename_column :chats, :sender_id, :owner_id
    rename_column :chats, :recipient_id, :friend_id
  end
end
