class RenameMemberId < ActiveRecord::Migration
  def change
    rename_column :attendances, :member_id, :membership_id
  end
end
