module FriendshipController

  def search_new_friends(search_text)
    friend_ids=@user.friends.select("id").map { |item| item.id }
    friend_requests_ids=@user.friend_requests.select("id").map{|item| item.id}

    ids=friend_ids.concat friend_requests_ids

    users=User.where("(email LIKE ? OR username LIKE ?) AND id NOT IN (?)",
                     "#{search_text}%", "#{search_text}%", ids)


    {:data => users.map{|user| PreviewFriendSerializer.new(user).attributes}}
  end

  def get_friends
    {:data => @user.serialized_friends}
  end

  def get_friend_by_id(id)
    result=Hash.new
    friend=@user.friends.find_by(id: id) rescue nil;
    if friend.nil?
      result[:error]={:msg => "Friend not found"}
    else
      result[:data]=friend.serialize_like_friend
    end
    result
  end

  def ask_for_new_friend(id)
    result=Hash.new

    if @user.friends.find_by(id: id).nil?
      if @user.friend_requests.find_by(id: id).nil?
        User.find(id).friend_requests << @user
        result[:data]= {:msg => "Friend request sent"}
      else
        result[:error]={:msg => "You have a request from this friend"}
      end

    else
      result[:error]={:msg => "It's your friend yet"}
    end


    result

  end

  def get_friend_requests
    {:data => @user.serialized_friend_requests}
  end

  def get_friend_request_by_id(id)
    result=Hash.new
    friend=@user.friend_requests.find_by(id: id) rescue nil;
    if friend.nil?
      result[:error]={:msg => "Possible Friend not found"}
    else
      result[:data]=friend.serialize_like_friend
    end
    result
  end

  def accept_friend(id)
    result=Hash.new
    request_user=@user.friend_requests.find_by(id: id)
    if not request_user.nil?
      FriendshipRequest.find_by(friend_request_id: id).destroy
      @user.friends << request_user

      result[:data]=@user.serialized_friends
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

      result[:data]=@user.serialized_friend_requests
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
      result[:data]=@user.serialized_friends
    else
      result[:error]={:msg => "Don't have that friend"}
    end

    result

  end


end

