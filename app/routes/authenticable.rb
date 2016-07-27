class Authenticable < Base
  before do
    @token=request.env["HTTP_AUTHORIZATION"]
    @user=OAuthController.validateToken(@token)
      halt 403,  error({msg:"No Authorization", auth:false})  if  @user.nil?

  end
end