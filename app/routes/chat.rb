module Routes
  class Chat < Authenticable
    include ChatController

    get "/chats" do
      resolve get_chats
    end

    get "/chats/messages" do
      resolve get_chats_messages
    end

    post "/chat" do
      @body=bind_body
      resolve create_chat
    end

    namespace "/chat/:id" do
      before do
        @chat_id=params["id"]
      end

      get "/messages" do
        resolve get_messages
      end

      put "/message" do
        @body=bind_body
        resolve create_message
      end
    end

  end
end
