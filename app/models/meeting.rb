class Meeting < ActiveRecord::Base
  before_create :create_uid
  after_create :create_attendances
  after_destroy :destroy_attendances

  belongs_to :team

  has_many :messages, :class_name => 'MeetingMessage', :foreign_key => "meeting_id"

  has_many :attendances, :dependent => :destroy
  has_many :attendants, :through => :attendances

  #Validation
  validates :name, presence: {message: "Name must be"}
  validates :start_at, presence: {message: "Start date must be"}
  validates :end_at, presence: {message: "End date must be"}

  def serialize
    MeetingSerializer.new(self).attributes
  end

  private
  def create_attendances
    attendances.create(
        team.memberships.map { |membership|
          {attendant: membership}
        }
    ) if not team.nil?
  end

  def destroy_attendances
    attendances.each{|attendance| attendance.destroy}
  end

  def create_uid
    self.uid = SecureRandom.uuid
  end

end