class Attendance < ActiveRecord::Base

  belongs_to :meeting
  belongs_to :attendant, :class_name => "Membership", :foreign_key =>  "membership_id"

end