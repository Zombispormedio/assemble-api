class PreviewFriendSerializer < ActiveModel::Serializer
  attributes :id, :email, :username,  :location, :full_avatar_url,:large_avatar_url, :medium_avatar_url, :thumb_avatar_url

end