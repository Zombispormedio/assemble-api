class RenameMeetingMessage < ActiveRecord::Migration
  def change
    rename_table :meetings_messages, :meeting_message
  end
end
