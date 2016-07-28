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

  def upload_avatar(file)
    result=Hash.new

    unless file &&
        (tmpfile = file[:tempfile]) &&
        (name = file[:filename])
      result[:error] = "No file selected"
    else

      base_dir="uploads/#{@user.uid}/"
      extname=Pathname(name).extname

      filename=SecureRandom.urlsafe_base64+extname

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

      result[:data]={:msg => "Avatar Changed"}
    end


    result
  end

end