module Routes
  class User < Authenticable
    include UserController

    get self.prefix do
      success( { msg: "Yes, you have authorization"})
    end

    get "/profile" do
      resolve get_profile @user_uid
    end

    get "/signout" do
      resolve signout @token, @user_uid
    end


  end

end
