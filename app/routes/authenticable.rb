class Authenticable < Base
  before do
    @user_uid=OAuthController.validateToken(request.env["HTTP_AUTHORIZATION"])
      halt 403,  error("No Authorization")  if  @user_uid.nil?

  end
end