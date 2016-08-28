class AddIndexToChats < ActiveRecord::Migration
  def change
    add_index :chats, :user_id
    add_index :chats, :friend_id
  end
end
