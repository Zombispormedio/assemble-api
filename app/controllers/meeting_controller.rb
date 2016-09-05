module MeetingController

  def get_meetings
    {:data => @user.serialized_meetings}
  end

end