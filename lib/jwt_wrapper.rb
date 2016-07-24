require 'jwt'

class JWTWrapper
  def initialize(secret)
    @secret=secret
  end

  def encode(payload)
    JWT.encode payload, @secret, 'HS256'
  end

  def decode(token)
    JWT.decode token, @secret, true, { :algorithm => 'HS256' }
  end

end