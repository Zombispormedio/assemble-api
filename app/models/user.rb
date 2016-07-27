require 'securerandom'

class User < ActiveRecord::Base
  include Utils

  validates :email, presence: { message: "Email must be"}
  validates :password, presence: { message: "Password must be"}
  validates :password, length: { in: 6..20, wrong_length: "Length range is 6-20"}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, format: { :with => VALID_EMAIL_REGEX , message: "Email format is invalid" }
  validates :email, uniqueness: {case_sensitive: false ,message: "You are registered"}

  validates :username, uniqueness: {case_sensitive: false ,message: "Username is used"}

  before_create do
    self.uid = SecureRandom.uuid
    self.username=getUniqueUsernameByEmail(self.email)  if self.username.nil?
    encryptPassword(self)
  end

  def getUniqueUsernameByEmail(email)
    prefix=email.split("@")[0]
    count=User.where("username LIKE '#{prefix}%'").count

    count==0? prefix : prefix+(count+2).to_s
  end

  def encryptPassword(this)
    this.salt=encrypt("#{this.uid}_#{Time.now.to_i}")
    this.password=encrypt("#{this.salt}_#{this.password}")
  end

  def authenticate(pass)
    self.password==encrypt("#{self.salt}_#{pass}")
  end


end