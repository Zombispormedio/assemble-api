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

      resolve get_friend_by_id(params["id"])

    end


  end
end