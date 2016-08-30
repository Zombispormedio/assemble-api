class RenameTeamsUsers < ActiveRecord::Migration
  def change
    rename_table  :teams_users, :memberships
  end
end
