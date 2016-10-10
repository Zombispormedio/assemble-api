class ChatSerializer < ActiveModel::Serializer
  attributes :id, :friend_id, :owner_id, :created_at
end