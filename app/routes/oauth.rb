module Routes
  class OAuth < Base
    include OAuthController


      post "/signup" do
        body=bind_body
        resolve  signup body["email"], body["password"]
      end


      post "/login" do
        body=bind_body
        resolve  login body["email"], body["password"]

      end


  end
end
