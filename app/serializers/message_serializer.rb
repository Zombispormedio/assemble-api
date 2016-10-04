class MessageSerializer < ActiveModel::Serializer
  attributes :id, :sender, :recipient, :created_at, :content, :is_read, :is_sent, :is_delivered

  def sender
    SenderSerializer.new(object.sender).attributes
  end

  def recipient
    SenderSerializer.new(object.recipient).attributes
  end

  def is_read
    object.is_read==nil ? false : object.is_read
  end

  def is_sent
    object.is_sent==nil ? false : object.is_sent
  end

  def is_delivered
    object.is_delivered==nil ? false : object.is_delivered
  end
end