module BaseController
  def profile
    ProfileSerializer.new(User.find_by uid: @user.uid).attributes
  end

  def upload(id, file)
    if file &&
        (tmpfile = file[:tempfile]) &&
        (name = file[:filename])

      base_dir="uploads/#{id}/"
      extname=Pathname(name).extname

      filename=SecureRandom.urlsafe_base64+extname.downcase

      Dir.mkdir base_dir unless File.exists?(base_dir)

      filepath=base_dir+filename

      File.open(filepath, 'wb') { |f| f.write tmpfile.read }

      image= ImageHelper.new filepath, id

      image.clear_remote

      image
    end
  end

end