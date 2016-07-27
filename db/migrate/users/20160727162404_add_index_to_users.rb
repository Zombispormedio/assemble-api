class AddIndexToUsers < ActiveRecord::Migration
  def change
    add_index :users, :uid
    add_index :users, :email
    add_index :users, :username
  end
end
