class DeleteGcm < ActiveRecord::Migration
  def change
    remove_column :users, :gcm_token
  end
end
