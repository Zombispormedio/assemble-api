class AddUidToAll < ActiveRecord::Migration
  def change
    add_column :meetings, :uid, :string
    add_column :meeting_messages, :uid, :string
    add_column :messages, :uid, :string
    add_column :teams, :uid, :string
    add_column :team_messages, :uid, :string
  end
end
