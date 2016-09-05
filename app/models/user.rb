class User < ActiveRecord::Base
  #mixins
  include Utils

  #friends
  has_many :friendships, dependent: :destroy
  has_many :friends, :through => :friendships

  has_many :friendship_requests, dependent: :destroy
  has_many :friend_requests, :through => :friendship_requests

  #teams
  has_many :memberships, :foreign_key => "member_id"
  has_many :teams, :through => :memberships

  has_many :team

  has_many :team_messages, foreign_key: "sender_id"

  has_many :meeting_messages, foreign_key: "sender_id"

  #chats
  has_many :chats, foreign_key: "owner_id", dependent: :destroy

  has_many :recipients, :through => :chats

  has_many :messages, foreign_key: "sender_id", dependent: :destroy


  #Validation
  validates :email, presence: {message: "Email must be"}
  validates :password, presence: {message: "Password must be"}
  validates :password, length: {in: 6..500, wrong_length: "Length range is 6-20"}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, format: {:with => VALID_EMAIL_REGEX, message: "Email format is invalid"}
  validates :email, uniqueness: {case_sensitive: false, message: "You are registered"}

  validates :username, uniqueness: {case_sensitive: false, message: "Username is used"}
  validates :username, presence: {message: "Username must be"}


  validates :bio, presence: {message: "Bio must be"}, on: :update, allow_blank: true
  validates :location, presence: {message: "Location must be"}, on: :update, allow_blank: true
  validates :birth_date, presence: {message: "Birthdate must be"}, on: :update, allow_blank: true


  before_create do
    self.uid = SecureRandom.uuid
    self.sign_up_at=Time.now
    self.username=getUniqueUsernameByEmail(self.email) if self.username.nil?
    encryptPassword
  end

  def getUniqueUsernameByEmail(email)
    prefix=email.split("@")[0]
    count=User.where("username LIKE '#{prefix}%'").count

    count==0 ? prefix : prefix+(count+2).to_s
  end

  def encryptPassword
    self.salt=encrypt("#{self.uid}_#{Time.now.to_i}")
    self.password=encrypt("#{self.salt}_#{self.password}")
  end

  def authenticate(pass)
    self.password==encrypt("#{self.salt}_#{pass}")
  end

  def serialized_teams
    self.teams.map{|team| PreviewTeamSerializer.new(team).attributes}
  end

  def serialized_meetings
    team_ids=self.teams.select("id")
    meetings=Meeting.where('team_id IN (?)', team_ids)

    meetings.map{|meeting| PreviewMeetingSerializer.new(meeting).attributes}
  end


end