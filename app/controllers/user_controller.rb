module UserController

  def get_profile(uid)
    result= Hash.new

    user=User.select("uid, email, username, name, birth_date, location, bio").find_by uid: uid

    if user.nil?
      result[:error]={msg: "User not exists"}
    else
      result[:data]=user
    end

    result
  end

  def signout(token, uid)
    SessionHelper.new.remove token

    User.find_by(uid: uid).update(last_sign_in_at: Time.now)

    {:data =>{:msg => "Sign out successfully"}}
  end

end