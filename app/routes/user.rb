module Routes
  class User < Authenticable
    include UserController

    get "/check_user" do
      success( { msg: "Yes, you have authorization"})
    end

    get "/profile" do
      resolve get_profile
    end

    get "/signout" do
      resolve signout
    end

    patch "/change_password" do
      body=bind_body
      resolve change_password body["password"]
    end

    patch "/change_email" do
      body=bind_body
      resolve change_email body["email"]
    end

    patch "/gcm" do
      @body=bind_body
      resolve refresh_gcm
    end


  end

end
