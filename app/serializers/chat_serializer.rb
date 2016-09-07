class ChatSerializer < ActiveModel::Serializer
  attributes :id, :sender, :recipient, :messages

  def sender
    SenderSerializer.new(object.owner).attributes
  end

  def recipient
    SenderSerializer.new(object.friend).attributes
  end

  def messages
    object.messages.map{|message| MessageSerializer.new(message).attributes}
  end
end