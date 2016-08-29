class RenameFromIdToSender < ActiveRecord::Migration
  def change
    rename_column :messages, :from_id, :sender_id
    rename_column :messages, :to_id, :recipient_id
  end
end
