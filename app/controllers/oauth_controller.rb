module OAuthController

  def signup(email, password)
    result= Hash.new


    result[:error]=User.create(email: email, encrypted_password: password).errors


    result

  end

end