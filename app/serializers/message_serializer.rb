class MessageSerializer < ActiveModel::Serializer
  attributes :id, :sender_id, :recipient_id, :created_at, :content, :is_read, :is_sent, :is_delivered

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