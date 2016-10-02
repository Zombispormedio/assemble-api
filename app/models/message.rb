class Message < ActiveRecord::Base

  belongs_to :sender, :class_name => "User", :foreign_key => "sender_id"
  belongs_to :recipient, :class_name => "User"

  before_create do
    self.uid = SecureRandom.uuid
  end

  validates :content, presence: {message: "Content must be"}

  def serialize
    MessageSerializer.new(self).attributes
  end
end