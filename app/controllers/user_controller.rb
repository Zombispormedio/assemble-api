module UserController

  def get_profile
    result= Hash.new

    user=User.select(Selection.PROFILE).find_by uid: @user.uid

    if user.nil?
      result[:error]={msg: "User doesn't exist"}
    else
      result[:data]=user
    end

    result
  end

  def signout
    SessionHelper.new.remove @token

    @user.update(last_sign_in_at: Time.now)

    result=Hash.new

    if @user.errors.any?
      result[:error]= @user.errors
    else
     result[:data]={:msg => "Sign out successfully"}
    end

    result

  end

  def change_email(new_email)
    result=Hash.new

    @user.update(email: new_email)

    unless @user.errors.any?
      result[:data]={:msg => "Email changed"}
    else
      result[:error]=@user.errors
    end

    return result
  end

  def change_password(new_password)
    result=Hash.new

    @user.password= new_password
    @user.encryptPassword
    @user.save

    unless @user.errors.any?
      result[:data]={:msg => "Password changed"}
    else
      result[:error]=@user.errors
    end

    return result
  end




end