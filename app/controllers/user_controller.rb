module UserController

  def get_profile(uid)
    result= Hash.new

    user=User.select("email, username, name, birth_date, location, bio").find_by uid: uid

    if user.nil?
      result[:error]={msg: "User not exists"}
    else
      result[:data]=user
    end

    result
  end

end