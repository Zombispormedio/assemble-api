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
    team_ids=@user.teams.select("id")
    meeting=Meeting.where('team_id IN (?) AND id=(?)', team_ids, @meeting_id).first

    if meeting.nil?
      result[:error]={:msg => "Meeting not found"}
    else
      result[:data]=meeting.serialize
    end
    result
  end

end