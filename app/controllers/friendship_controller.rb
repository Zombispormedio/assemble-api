module FriendshipController

  def search_new_friends(search_text)
    ids=[@user.id]
    if @user.friends.size >0
      friend_ids=@user.friends.select("id").map { |item| item.id }
      ids=ids.concat friend_ids

    end

    if @user.friend_requests.size >0
      friend_requests_ids=@user.friend_requests.select("id").map { |item| item.id }
      ids= ids.concat friend_requests_ids
    end

    users=User.where("(email LIKE ? OR username LIKE ?) AND id NOT IN (?)",
                     "#{search_text}%", "#{search_text}%", ids)

    users=users.map do |user|
        serialized_user=PreviewFriendSerializer.new(user).attributes

        in_request=FriendshipRequest.find_by(friend_request_id: @user.id, user_id:serialized_user[:id] ) rescue nil

        unless in_request.nil?
          serialized_user[:in_request]=true
        end
        serialized_user

    end


    {:data => users}
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

      result[:data]=@user.serialized_friend_requests
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

