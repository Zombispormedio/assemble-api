class TeamMessage < ActiveRecord::Base

  belongs_to :team
  belongs_to :sender, :class_name => "User", :foreign_key => "sender_id"

  before_create do
    self.uid = SecureRandom.uuid
  end
end