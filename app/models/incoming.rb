class Incoming < ActiveRecord::Base
  after_create :create_reverse_incoming
  after_destroy :destroy_message, :destroy_reverse_incoming

  belongs_to :chat
  belongs_to :message

  def create_reverse_incoming

    reverse_chat=Chat.find_by(owner: chat.friend, friend: chat.owner)

    if reverse_chat.messages.find_by(id: message.id).nil?
      reverse_chat.messages << message
      add_header_message
      add_sender
    end

  end

  def add_header_message
    message.sender_id=chat.owner.id
    message.recipient_id=chat.friend.id
    message.save
  end

  def add_sender
    sender_id=message.sender_id
    reverse_incoming=get_reverse_incoming[0]
    self.update(sender_id: sender_id)
    reverse_incoming.update(sender_id: sender_id)
  end

  def destroy_reverse_incoming
    reverse_incoming=get_reverse_incoming[0]
    unless reverse_incoming.nil?
      reverse_incoming.destroy
    end
  end

  def destroy_message
   message= Message.find(self.message_id) rescue nil;

    unless message.nil?
      message.destroy
    end

  end

  def get_reverse_incoming
    Incoming.where("id != ? AND message_id = ?", self.id, self.message_id)
  end
end