class PreviewTeamSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :created_at, :full_image_url, :large_image_url, :medium_image_url, :thumb_image_url
end