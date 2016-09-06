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


    put "/meeting/:id" do
      @body=bind_body
      @meeting_id=params["id"]
      resolve change_meeting
    end

    delete "/meeting/:id" do
      @meeting_id=params["id"]
      resolve remove_meeting
    end

    namespace "/meeting/:id" do
      before do
        @meeting_id=params["id"]
      end

      patch "/image" do
        @meeting_image=params["image"];
        resolve upload_image
      end

      get "/attendants" do
        resolve get_attendants
      end

    end
  end
end
