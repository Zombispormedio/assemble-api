class RenameMembershipsToOther < ActiveRecord::Migration
  def change
    rename_table :memberships, :teams_users
  end
end
