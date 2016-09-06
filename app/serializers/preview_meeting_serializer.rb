class PreviewMeetingSerializer  < ActiveModel::Serializer
  attributes :id, :name, :description, :start_at, :end_at, :team, :created_at,  :full_image_url, :large_image_url, :medium_image_url, :thumb_image_url

  def team
    PreviewTeamSerializer.new(object.team).attributes
  end
end