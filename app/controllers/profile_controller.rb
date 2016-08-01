module ProfileController

  def upload_avatar(file)
    result=Hash.new

    unless file &&
        (tmpfile = file[:tempfile]) &&
        (name = file[:filename])
      result[:error] = "No file selected"
    else

      base_dir="uploads/#{@user.uid}/"
      extname=Pathname(name).extname

      filename=SecureRandom.urlsafe_base64+extname.downcase

      Dir.mkdir base_dir unless File.exists?(base_dir)

      filepath=base_dir+filename

      File.open(filepath, 'wb') { |f| f.write tmpfile.read }


      image= ImageHelper.new filepath, @user.uid

      image.clear

      @user.full_avatar_url=image.full
      @user.large_avatar_url=image.large
      @user.medium_avatar_url=image.medium
      @user.thumb_avatar_url=image.thumb

      @user.save

      FileUtils.rm_rf base_dir

      result[:data]=User.select(Selection.PROFILE).find_by uid: @user.uid
    end
    return result
  end


  def change_username(new_username)
    result=Hash.new

    @user.update(username: new_username)


    unless @user.errors.any?
      result[:data]={:msg => "Username changed"}
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
      result[:data]={:msg => "Bio changed"}
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
      result[:data]={:msg => "Location changed"}
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
      result[:data]={:msg => "Birthdate changed"}
    else
      result[:error]=@user.errors
    end

    return result
  end


end