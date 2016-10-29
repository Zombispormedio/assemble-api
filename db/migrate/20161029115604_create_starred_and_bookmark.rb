class CreateStarredAndBookmark < ActiveRecord::Migration
  def self.up
    create_table :starreds do |t|
      t.integer :user_id
      t.integer :team_id
    end

    create_table :bookmarks do |t|
      t.integer :user_id
      t.integer :meeting_id
    end

  end

  def self.down
    drop_table :starreds
    drop_table :bookmarks
  end

end
