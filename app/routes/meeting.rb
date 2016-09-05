module Routes
  class Meeting < Authenticable
    include MeetingController


    get "/meetings" do
      resolve get_meetings
    end

  end
end
