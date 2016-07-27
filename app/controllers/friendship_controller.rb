module FriendshipController

  def search_new_friends(search_text)
    friend_ids=@user.friends.select("id").map{|item| item.id}

    users=User.select("id, email, username, name")
              .where("(email LIKE ? OR username LIKE ? OR name LIKE ?) AND id NOT IN (?)",
                     "#{search_text}%", "#{search_text}%","#{search_text}%", friend_ids)


    {:data=>users}
  end

  def get_friends
    friends=@user.friends.select("friend_id, email, username, name")

    {:data=>friends}

  end

  def get_friend_by_id(id)
    friend=@user.friends.select("friend_id, email, username, name, birth_date, location, bio, sign_up_at").find_by(id: id)
    {:data=>friend}
  end

  def ask_for_new_friend(id)
    result=Hash.new

    if @user.friends.find_by(id: id).nil?
      if @user.friend_requests.find_by(id: id).nil?
        User.find(id).friend_requests  << @user
        result[:data]={:msg => "Friend request sent"}
      else
        result[:error]={:msg => "You have a request from this friend"}
      end

    else
      result[:error]={:msg => "It's your friend yet"}
    end


    result

  end

  def get_friend_requests
    friends=@user.friend_requests.select("friend_request_id, email, username, name")

    {:data=>friends}
  end

  def get_friend_request_by_id(id)
    friend=@user.friend_requests.select("friend_request_id, email, username, name, birth_date, location, bio, sign_up_at").find_by(id: id)
    {:data=>friend}
  end

  def accept_friend(id)
    result=Hash.new
    request_user=@user.friend_requests.find_by(id: id)
    if not request_user.nil?
        FriendshipRequest.find_by(friend_request_id: id).destroy
        @user.friends << request_user

        result[:data]={:msg => "Friend request accepted"}
    else
      result[:error]={:msg => "Don't have that friend request"}
    end

    result

  end

  def reject_friend(id)
    result=Hash.new
    request_user=@user.friend_requests.find_by(id: id)
    if not request_user.nil?
      FriendshipRequest.find_by(friend_request_id: id).destroy

      result[:data]={:msg => "Friend request rejected"}
    else
      result[:error]={:msg => "Don't have that friend request"}
    end

    result

  end

  def delete_friend(id)
    result=Hash.new
    friend=@user.friends.find_by(id: id)
    if not friend.nil?
      Friendship.find_by(friend_id: id).destroy

      result[:data]={:msg => "Friend removed"}
    else
      result[:error]={:msg => "Don't have that friend"}
    end

    result

  end



end



#user.friends.destroy( User.find(90))
#user.friends << User.find(90)
#user.friends.select("id")