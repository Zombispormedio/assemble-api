class Authenticable < Base
  helpers do
    def authenticate!
      @token=request.env["HTTP_AUTHORIZATION"]
      @user=OAuthController.validateToken(@token)
     not @user.nil?
    end
  end

  before do
      halt 403,  error({msg:"No Authorization", auth:false})  unless  authenticate!

  end
end