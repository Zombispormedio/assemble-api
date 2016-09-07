module ChatController

  def get_chats
    {:data => @user.serialized_chats}
  end

  def create_chat
    result=Hash.new

   if not @body.include?("friend")
     result[:error]={:msg => "Where is your friend"};
     return result
   end

    friend=@user.friends.find_by(id: @body["friend"]) rescue nil;

    if friend.nil?
      result[:error]={:msg => "Sorry, it's not your friend. Try to do it."};
      return result
    end

    have_chat=@user.chats.find_by(friend_id: @body["friend"]) rescue nil;

    if not have_chat.nil?
      result[:error]={:msg => "You have chat with your friend"};
      return result
    end

    chat=@user.chats.create(friend: friend)

    if chat.errors.any?
      result[:error]=chat.errors
    else
      result[:data]=chat.serialize
    end

    result
  end

end