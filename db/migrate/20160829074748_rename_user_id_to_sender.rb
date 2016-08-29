class RenameUserIdToSender < ActiveRecord::Migration
  def change
    rename_column :chats, :user_id, :sender_id
    rename_column :chats, :friend_id, :recipient_id
  end
end
