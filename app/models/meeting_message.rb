class MeetingMessage < ActiveRecord::Base

  belongs_to :meeting, :foreign_key => "meeting_id"
  belongs_to :sender, :class_name => "User", :foreign_key => "sender_id"

end