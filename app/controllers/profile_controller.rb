module ProfileController
  include BaseController

  def upload_avatar(file)
    result=Hash.new

    image=upload(@user.uid, file)

    if image.nil?
      result[:error]={:msg=>"No file selected"}
    else
      @user.full_avatar_url=image.full
      @user.large_avatar_url=image.large
      @user.medium_avatar_url=image.medium
      @user.thumb_avatar_url=image.thumb
      @user.save
      image.clean
      result[:data]=profile
    end
    return result
  end


  def change_username(new_username)
    result=Hash.new

    @user.update(username: new_username)


    unless @user.errors.any?
      result[:data]=profile
    else
      result[:error]=@user.errors
    end

    return result
  end


  def change_bio(new_bio)
    result=Hash.new

    unless new_bio.nil?
      @user.update(bio: new_bio)
    else
      result[:error]={:msg => "New location is invalid"}
      return result
    end

    unless @user.errors.any?
      result[:data]=profile
    else
      result[:error]=@user.errors
    end

    return result

  end


  def change_location(new_location)
    result=Hash.new
    unless new_location.nil?
      @user.update(location: new_location)
    else
      result[:error]={:msg => "New location is invalid"}
      return result

    end

    unless @user.errors.any?
      result[:data]=profile
    else
      result[:error]=@user.errors
    end

    return result
  end


  def change_birth_date(new_birth_date)
    result=Hash.new

    unless new_birth_date.nil?
      @user.update(birth_date: new_birth_date)
    else
      result[:error]={:msg => "New birthdate is invalid"}
      return result

    end

    unless @user.errors.any?
      result[:data]=profile
    else
      result[:error]=@user.errors
    end

    return result
  end

  def change_profile(params)
    result=Hash.new

    @user.username=params["username"]

    @user.bio=params["bio"]

    @user.location=params["location"]

    @user.birth_date=params["birth_date"]

    @user.save

    unless @user.errors.any?
      result[:data]=profile
    else
      result[:error]=@user.errors
    end

    return result
  end


end