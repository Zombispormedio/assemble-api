class AddIndexToMembers < ActiveRecord::Migration
  def change
    add_index :memberships, :team_id
    add_index :memberships, :user_id
  end
end
