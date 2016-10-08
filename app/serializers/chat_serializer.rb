class ChatSerializer < ActiveModel::Serializer
  attributes :id, :friend_id, :owner_id, :last_message
  def last_message
    last=object.messages.order("created_at ASC").last
    MessageSerializer.new(last).attributes
  end
end