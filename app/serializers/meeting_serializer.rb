class MeetingSerializer  < ActiveModel::Serializer
  attributes :id, :name, :description, :day, :start_hour, :end_hour, :team, :attendants, :created_at,  :full_image_url, :large_image_url, :medium_image_url, :thumb_image_url

  def team
    PreviewTeamSerializer.new(object.team).attributes
  end

  def attendants

    object.attendances.map do |attendance|
      attendant=MemberSerializer.new(attendance.attendant.member).attributes
      attendant[:attend?]=attendance.attend?
      attendant
    end
  end
end