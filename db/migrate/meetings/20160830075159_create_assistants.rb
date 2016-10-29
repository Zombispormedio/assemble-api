class CreateAssistants < ActiveRecord::Migration
  def self.up
    create_table :assistants do |t|
      t.integer :meeting_id
      t.integer :member_id
      t.boolean :attendance
      t.timestamps
    end
  end

  def self.down
    drop_table :assistants
  end
end
