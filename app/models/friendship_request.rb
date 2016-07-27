class FriendshipRequest < ActiveRecord::Base

  belongs_to :user
  belongs_to :friend_request, :class_name => "User"

end