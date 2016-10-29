class AddIndexToFriendrequests < ActiveRecord::Migration
  def change
    add_index :friendship_requests, :friend_request_id
    add_index :friendship_requests, :user_id
  end
end
