module OAuthController

  def signup(email, password)
    result= Hash.new

    promise=User.create(email: email, password: password)
    if promise.errors.any?
      result[:error]=promise.errors
    else
      result[:data]={msg: "Sign up successfully"}
    end
    result

  end

  def login(email, password)
    result= Hash.new

    user=User.find_by email: email

    if user.nil?
      result[:error]={msg: "User doesn't exist"}
    else

      if user.authenticate password

        if not user.update(current_sign_in_at: Time.now)
          result[:error]=user.errors
        else
          session=SessionHelper.new

          token=session.generate user.uid

          result[:data]={token: token}

          session.finish

        end


      else
        result[:error]={msg: "Wrong password"}
      end

    end

    result
  end

  def self.validate_token(token)
    user = nil
    unless token.nil?
      session=SessionHelper.new
      uid= session.get_user token
      session.finish
      user=User.find_by(uid: uid)
    end
    user
  end

end