module MeetingController
  include BaseController

  def get_meetings
    {:data => @user.serialized_meetings}
  end

  def create_meeting
    result=Hash.new

    team=@user.teams.find(@body["team"]) rescue nil

    if team.nil?
      result[:error]={:msg => "Team not found"}
      return result
    end

    fields=get_fields_meeting(@body)

    meeting=team.meetings.create(fields)

    if meeting.errors.any?
      result[:error]=meeting.errors
    else
      result[:data]=meeting.serialize
    end

    result
  end

  def get_meeting_by_id
    result=Hash.new
    meeting= get_meeting

    if meeting.nil?
      result[:error]={:msg => "Meeting not found"}
    else
      result[:data]=meeting.serialize
    end
    result
  end


  def change_meeting
    result=Hash.new
    meeting= get_meeting

    if meeting.nil?
      result[:error]={:msg => "Meeting not found"}
      return result
    end

    fields=get_fields_meeting(@body)

    meeting.update(fields)

    if meeting.errors.any?
      result[:error]=meeting.errors
    else
      result[:data]=meeting.serialize
    end

    result
  end

  def upload_image
    result=Hash.new
    meeting=get_meeting

    if meeting.nil?
      result[:error]={:msg => "Meeting not found"}
      return result
    end

    image=upload(meeting.uid, @meeting_image)

    if image.nil?
      result[:error]={:msg => "No file selected"}
    else
      meeting.full_image_url=image.full
      meeting.large_image_url=image.large
      meeting.medium_image_url=image.medium
      meeting.thumb_image_url=image.thumb
      meeting.save
      image.clean
      if meeting.errors.any?
        result[:error]=meeting.errors
      else
        result[:data]=meeting.serialize
      end
    end
    result

  end

  def get_attendants
    result=Hash.new
    meeting=get_meeting
    result[:data]= meeting.attendances.map do |attendance|
      attendant=MemberSerializer.new(attendance.attendant.member).attributes
      attendant[:attend?]=attendance.attend?
      attendant
    end

    result
  end

  def remove_meeting
    meeting=get_meeting

    meeting.destroy

    get_meetings
  end

end