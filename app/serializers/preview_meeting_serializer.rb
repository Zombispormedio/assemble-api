class PreviewMeetingSerializer  < ActiveModel::Serializer
  attributes :id, :name, :description, :day, :start_hour, :end_hour, :team, :created_at,  :full_image_url, :large_image_url, :medium_image_url, :thumb_image_url

  def team
    PreviewTeamSerializer.new(object.team).attributes
  end
end