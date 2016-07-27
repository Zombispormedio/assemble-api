class ChangeIdFriendshipRequest < ActiveRecord::Migration
  def change
    rename_column :friendship_requests, :new_friend_id, :friend_request_id
  end
end
