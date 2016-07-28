class CreateFriendshipRequest < ActiveRecord::Migration
  def self.up
    create_table :friendship_requests do |t|
      t.integer :user_id
      t.integer :new_friend_id
      t.timestamps
    end
  end

  def self.down
    drop_table :friendship_requests
  end
end
