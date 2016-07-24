require_relative "../../lib/redis_wrapper"
require_relative "../../lib/jwt_wrapper"
class SessionHelper

  def initialize
    @redis=RedisWrapper.new ENV["REDIS_HOST"], ENV["REDIS_PORT"], ENV["REDIS_AUTH"]
    @jwt=JWTWrapper.new ENV["SECRET"]
  end

  def generate(uid)

    payload={
        uid: uid,
        timestamp: Time.now.to_i
    }

    token= @jwt.encode payload

    @redis.set(token, true)

    token

  end

  def valid?(token)
    @redis.get(token) == 'true'
  end

  def get_user(token)
    if valid? token
      result=@jwt.decode(token)

      result[0]["uid"] if result.length >0
    end


  end

  def finish
    @redis.close

  end



end