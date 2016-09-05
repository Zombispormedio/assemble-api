module Routes
  class Team < Authenticable
    include TeamController

    get "/teams" do
      resolve get_teams
    end

    post "/team" do
      body=bind_body
      resolve create_team body
    end

    get "/team/:id" do
      @team_id=params["id"]
      resolve get_team_by_id
    end

    put "/team/:id" do
      @body=bind_body
      @team_id=params["id"]
      resolve change_team
    end


    namespace "/team/:id" do
      before do
        @team_id=params["id"]
      end

      patch "/image" do
        @team_image=params["image"];
        resolve upload_image
      end


      get "/admin" do
        resolve get_admin
      end

      patch "/admin" do
        @admin_id=bind_body["admin"]
        resolve change_admin
      end

      get "/members" do
        resolve get_members
      end

      patch "/members" do
        @new_members=bind_body["members"]
        resolve add_members
      end

      patch "/delete_member" do
        @q_member=bind_body["member"]
        resolve delete_member
      end

      get "/leave" do
        resolve leave_team
      end

      get "/meetings" do
        resolve get_meetings
      end

      post "/meeting" do
        @body=bind_body
        resolve create_meeting_for_team
      end

      get "/messages" do
        resolve get_messages
      end

    end
  end
end