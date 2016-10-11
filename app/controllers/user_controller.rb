module UserController
  include BaseController

  def get_profile
    result= Hash.new

    user=profile

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

    if not @user.errors.any?
      result[:data]={:msg => "Email changed"}
    else
      result[:error]=@user.errors
    end

    result
  end

  def change_password(new_password)
    result=Hash.new

    @user.password= new_password
    @user.encryptPassword
    @user.save

    if not @user.errors.any?
      result[:data]={:msg => "Password changed"}
    else
      result[:error]=@user.errors
    end

    result
  end

  def refresh_gcm
    result=Hash.new

    unless @body.include?("gcm_token")
      result[:error]={:msg=>"Where is GCM token?"}
      return result
    end

    @user.update(gcm_token: @body["gcm_token"])

    if not @user.errors.any?
      result[:data]={:msg => "GCM changed"}
    else
      result[:error]=@user.errors
    end

    result
  end




end