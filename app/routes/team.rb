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
      resolve get_team_by_id params["id"]
    end

    put "/team/:id" do
      body=bind_body
      resolve change_team params["id"], body
    end


    namespace "/team/:id" do

      get "/admin" do
        resolve get_admin params["id"]
      end

      get "/members" do
        resolve get_members params["id"]
      end

      get "/meetings" do
        resolve get_meetings params["id"]
      end

      get "/messages" do
        resolve get_messages params["id"]
      end

    end
  end
end