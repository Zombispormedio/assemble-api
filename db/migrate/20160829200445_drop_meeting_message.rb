class DropMeetingMessage < ActiveRecord::Migration
  def change
    drop_table :meeting_message
  end
end
