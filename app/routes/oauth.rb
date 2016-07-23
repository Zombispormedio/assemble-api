module Routes
  class OAuth < Base
    include OAuthController
    include ResponseHelper

    namespace self.prefix do

      post "/signup" do
        request.body.rewind
        body = JSON.parse(request.body.read)
        result=signup(body["email"], body["password"])
        if result[:error] !=nil
          error(result[:error])
        else
          success(result[:data])
        end
      end





    end

  end
end
