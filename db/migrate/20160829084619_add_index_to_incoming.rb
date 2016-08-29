class AddIndexToIncoming < ActiveRecord::Migration
  def change
    add_index :incomings, :chat_id
    add_index :incomings, :sender_id
    add_index :incomings, :message_id
  end
end
