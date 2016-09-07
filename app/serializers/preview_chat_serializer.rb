class PreviewChatSerializer < ActiveModel::Serializer
  attributes :id, :sender, :recipient, :created_at

  def sender
    SenderSerializer.new(object.owner).attributes
  end

  def recipient
    SenderSerializer.new(object.friend).attributes
  end

end