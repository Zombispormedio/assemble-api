module Routes
  class OAuth < Base
    include OAuthController


    post "/signup" do
      @body=bind_body
      resolve signup
    end


    post "/login" do
      @body=bind_body
      resolve login

    end


  end
end
