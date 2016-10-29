class CreateIncomings < ActiveRecord::Migration
  def self.up
    create_table :incomings do |t|
      t.integer :chat_id
      t.integer :sender_id
      t.integer :message_id
      t.boolean :is_read
      t.boolean :is_sent
      t.boolean :is_delivered
      t.timestamps
    end
  end

  def self.down
    drop_table :incomings
  end

end
