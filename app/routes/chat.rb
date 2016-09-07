module Routes
  class Chat < Authenticable
    include ChatController

    get "/chats" do
      resolve get_chats
    end

    post "/chat" do
      @body=bind_body
      resolve create_chat
    end

  end
end
