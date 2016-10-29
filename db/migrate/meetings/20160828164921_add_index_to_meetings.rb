class AddIndexToMeetings < ActiveRecord::Migration
  def change
    add_index :meetings, :team_id
  end
end
