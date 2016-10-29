class RenameAndRemoveAndElseInMeeting < ActiveRecord::Migration
  def change
    rename_column :meetings, :day, :start_at
    add_column :meetings, :end_at, :datetime
    remove_column :meetings, :start_hour
    remove_column :meetings, :end_hour
  end
end
