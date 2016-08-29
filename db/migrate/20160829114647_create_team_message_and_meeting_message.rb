class CreateTeamMessageAndMeetingMessage < ActiveRecord::Migration
  def self.up
    create_table :team_messages do |t|
      t.integer :team_id
      t.integer :sender_id
      t.string :content
      t.timestamps
    end

    create_table :meetings_messages do |t|
      t.integer :meeting_id
      t.integer :sender_id
      t.string :content
      t.timestamps
    end
  end

  def self.down
    drop_table :team_messages
    drop_table :meetings_messages
  end
end
