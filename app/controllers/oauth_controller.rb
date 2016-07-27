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
      result[:error]={msg:"User not exists"}
    else

       if user.authenticate password

         session=SessionHelper.new

         token=session.generate user.uid

         result[:data]={token:token}

         session.finish


       else
         result[:error]={msg:"Bad password"}
       end

    end

    result
  end

  def self.validateToken(token)
    uid = nil
    if not token.nil?
      session=SessionHelper.new
      uid= session.get_user token
      session.finish

      uid=nil if User.find_by(uid: uid).nil?

    end
    uid
  end

end