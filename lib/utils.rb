require 'digest/sha1'

module Utils

  def encrypt(value)
    Digest::SHA1.hexdigest(value)
  end

end