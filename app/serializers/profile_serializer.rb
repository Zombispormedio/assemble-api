class ProfileSerializer < ActiveModel::Serializer
  attributes :id, :email, :username, :birth_date, :location, :bio, :sign_up_at, :full_avatar_url, :large_avatar_url, :medium_avatar_url, :thumb_avatar_url
end