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

  def get_fields_meeting(body)
    fields=Hash.new

    if body.include?("name")
      fields[:name]=body["name"]
    end

    if body.include?("description")
      fields[:description]=body["description"]
    end

    if body.include?("day")
      fields[:day]=body["day"]
    end

    if body.include?("start_hour")
      fields[:start_hour]=body["start_hour"]
    end

    if body.include?("end_hour")
      fields[:end_hour]=body["end_hour"]
    end

    fields
  end

end