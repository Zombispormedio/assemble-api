class Incoming < ActiveRecord::Base
  after_create :create_reverse_incoming, :add_header_message
  after_destroy :destroy_reverse_incoming

  belongs_to :chat
  belongs_to :message

  def create_reverse_incoming
    reverse_chat=Chat.find_by(owner: chat.friend)
    reverse_chat.messages << message if reverse_chat.messages.find_by(id: message.id).nil?
  end

  def add_header_message
    message.sender_id=chat.owner.id
    message.recipient_id=chat.friend.id
    message.save
  end
  def destroy_reverse_incoming
    reverse_chat=Chat.find_by(friend: chat.owner)
    reverse_chat.destroy if  reverse_chat
  end
end