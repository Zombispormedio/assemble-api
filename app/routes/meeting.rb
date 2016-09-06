module Routes
  class Meeting < Authenticable
    include MeetingController


    get "/meetings" do
      resolve get_meetings
    end

    post "/meeting" do
      @body=bind_body
      resolve create_meeting
    end

    get "/meeting/:id" do
      @meeting_id=params["id"]
      resolve get_meeting_by_id
    end
  end
end
