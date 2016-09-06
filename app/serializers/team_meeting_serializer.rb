class TeamMeetingSerializer  < ActiveModel::Serializer
  attributes :id, :name, :description, :start_at, :end_at, :created_at,  :full_image_url, :large_image_url, :medium_image_url, :thumb_image_url
end