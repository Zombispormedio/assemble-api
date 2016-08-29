class Chat < ActiveRecord::Base
  after_create :create_reverse_chat
  after_destroy :destroy_reverse_chat

  belongs_to :owner, :class_name => "User", :foreign_key => "owner_id"
  belongs_to :friend, :class_name => "User"

  has_many :incomings, dependent: :destroy
  has_many :messages, :through => :incomings

  private

  def create_reverse_chat
    chat=friend.chats.find_by(friend: owner)
    friend.chats.create(friend: owner) if chat.nil?
  end

  def destroy_reverse_chat
    chat=friend.chats.find_by(friend: owner)
    chat.destroy if chat

  end
end