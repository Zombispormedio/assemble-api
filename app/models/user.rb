
class User < ActiveRecord::Base
  validates :email, presence: { message: "Email must be"}
  validates :password, presence: { message: "Password must be"}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { :with => VALID_EMAIL_REGEX , message: "Email format is invalid" }
  validates :email, uniqueness: {case_sensitive: false ,message: "you are registered"}

end