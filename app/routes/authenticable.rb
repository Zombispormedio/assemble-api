class Authenticable < Base
  before do
    @token=request.env["HTTP_AUTHORIZATION"]
    @user_uid=OAuthController.validateToken(@token)
      halt 403,  error("No Authorization")  if  @user_uid.nil?

  end
end