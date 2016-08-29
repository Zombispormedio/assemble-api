class Meeting < ActiveRecord::Base

  belongs_to :team

  has_many :messages, :class_name => 'MeetingMessage',  :foreign_key => "meeting_id"

end