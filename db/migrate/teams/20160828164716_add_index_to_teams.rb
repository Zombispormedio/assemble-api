class AddIndexToTeams < ActiveRecord::Migration
  def change
    add_index :teams, :admin_id
  end
end
