module OAuthController

  def signup
    result= Hash.new

    fields=Hash.new

    fields[:email]=@body["email"]
    fields[:password]=@body["password"]

    if @body.include?("gcm_token")
      gcm_token=@body["gcm_token"]
      fields[:gcm_token]=gcm_token unless gcm_token.nil?
    end

    promise=User.create(fields)
    if promise.errors.any?
      result[:error]=promise.errors
    else
      result[:data]={msg: "Sign up successfully"}
    end
    result

  end

  def login
    result= Hash.new

    user=User.find_by email: @body["email"]

    if user.nil?
      result[:error]={msg: "User doesn't exist"}
    else

      if user.authenticate @body["password"]

        fields=Hash.new

        fields[:current_sign_in_at]=Time.now

        if @body.include?("gcm_token")
          gcm_token=@body["gcm_token"]
          fields[:gcm_token]=gcm_token unless gcm_token.nil?
        end

        if not user.update(fields)
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