module OAuthController

  def signup(email, password)
    result= Hash.new

    result[:data]=email;

    return result

  end

end