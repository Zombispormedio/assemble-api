require "redis"
class RedisWrapper

  def initialize(host, port, password)
    @redis = Redis.new :host => host, :port => port, :password=> password
  end

  def set(key, value)
    @redis.setex(key, ENV["TTL"], value)
  end

  def get(key)
    @redis.get(key)
  end

  def get_keys_by_pattern(pattern)
    @redis.scan(pattern)
  end

  def close
    @redis.quit
  end


end