module UserController

  def get_profile(uid)
    result= Hash.new

    user=User.select("id, email, username, name, birth_date, location, bio").find_by uid: uid

    if user.nil?
      result[:error]={msg: "User not exists"}
    else
      result[:data]=user
    end

    result
  end

  def signout(token, user)
    SessionHelper.new.remove token

    user.update(last_sign_in_at: Time.now)

    result=Hash.new

    if user.errors.any?
      result[:error]= user.errors
    else
     result[:data]={:msg => "Sign out successfully"}
    end

    result

  end

end