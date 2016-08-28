class CreateMeetings < ActiveRecord::Migration
  def self.up
    create_table :meetings do |t|
      t.integer :team_id
      t.string :name
      t.string :description
      t.datetime :day
      t.string :start_hour
      t.string :end_hour
      t.timestamps
    end
  end

  def self.down
    drop_table :meetings
  end
end
