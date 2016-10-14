module ChatController

  def get_chats
    {:data => @user.serialized_chats}
  end

  def create_chat
    result=Hash.new

    unless @body.include?("friend")
      result[:error]={:msg => "Where is your friend"}
      return result
    end

    friend=@user.friends.find_by(id: @body["friend"]) rescue nil

    if friend.nil?
      result[:error]={:msg => "Sorry, it's not your friend. Try to do it."}
      return result
    end

    have_chat=@user.chats.find_by(friend_id: @body["friend"]) rescue nil

    unless have_chat.nil?
      result[:error]={:msg => "You have chat with your friend"}
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

  def get_messages
    result=Hash.new
    chat=@user.chats.find(@chat_id) rescue nil
    if chat.nil?
      result[:error]={:msg => "You don't have this chat"}
      return result
    end

    result[:data]=chat.serialized_messages

    result
  end

  def create_message
    result=Hash.new
    chat=@user.chats.find(@chat_id) rescue nil
    if chat.nil?
      result[:error]={:msg => "You don't have this chat"}
      return result
    end

    message=chat.messages.create(content: @body["content"], is_sent: true)

    if message.errors.any?
      result[:error]=message.errors
    else
      t=message.serialize
      t[:chat_id]=@chat_id
      result[:data]=t
    end

    unless @user.gcm_token.nil?
      notification= Notification.new

      notification.title_key("new_message_title")
          .click_action("NEW_MESSAGE_ACTION")
          .body(message.content)
          .user(@user.gcm_token)
          .set_data(message)
          .send
    end

    result
  end


  def get_chats_messages
    Message.where(recipient_id: 66, is_read: nil, is_sent: true).update_all(is_delivered: true)
    {:data => @user.serialized_chats_messages}
  end


  def read_messages
    result=Hash.new
    chat=@user.chats.find(@chat_id) rescue nil
    if chat.nil?
      result[:error]={:msg => "You don't have this chat"}
      return result
    end
    messages= chat.messages.where(id: @body["messages"])

    messages.update_all(is_read: true)

    result[:data]=messages.map { |msg| msg.serialize }

    result
  end

end