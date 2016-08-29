class RemoveAddColumnToIncomingMessage < ActiveRecord::Migration
  def change
    remove_column :incomings, :is_read
    remove_column :incomings, :is_sent
    remove_column :incomings,  :is_delivered
    add_column :messages, :is_read, :boolean
    add_column :messages, :is_sent, :boolean
    add_column :messages, :is_delivered, :boolean
  end
end
