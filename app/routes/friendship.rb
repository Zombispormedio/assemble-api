module Routes
  class Friendship < Authenticable
    include FriendshipController

    get "/new_friends/:search_text" do

      resolve search_new_friends params['search_text']

    end

    get "/friends" do

      resolve get_friends

    end

    get "/friend/:id" do

      resolve get_friend_by_id params["id"]

    end

    post "/new_friend/:id" do

      resolve ask_for_new_friend params["id"]

    end

    get "/friend_requests" do

      resolve get_friend_requests

    end

    get "/friend_request/:id" do
      resolve get_friend_request_by_id params["id"]
    end

    post "/accept_friend/:id" do

      resolve accept_friend params["id"]

    end

    post "/reject_friend/:id" do

      resolve reject_friend params["id"]

    end

    delete "/delete_friend/:id" do

      resolve delete_friend params["id"]

    end

  end
end