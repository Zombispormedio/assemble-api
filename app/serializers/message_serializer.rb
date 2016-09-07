class MessageSerializer < ActiveModel::Serializer
    attributes :id, :sender, :recipient, :created_at, :content, :is_read, :is_sent, :is_delivered

    def sender
      SenderSerializer.new(object.sender).attributes
    end

    def recipient
      SenderSerializer.new(object.recipient).attributes
    end
end