class CreateMeetingMessages < ActiveRecord::Migration
  def self.up
    create_table :meeting_messages do |t|
      t.integer :meeting_id
      t.integer :sender_id
      t.string :content
      t.timestamps
    end
  end

  def self.down
    drop_table :meeting_messages
  end
end
