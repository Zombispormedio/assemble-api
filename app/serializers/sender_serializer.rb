class SenderSerializer < ActiveModel::Serializer
  attributes :id, :email, :username, :full_avatar_url, :large_avatar_url, :medium_avatar_url, :thumb_avatar_url
end