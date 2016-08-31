module BaseController
  def profile
    ProfileSerializer.new(User.find_by uid: @user.uid).attributes
  end

end