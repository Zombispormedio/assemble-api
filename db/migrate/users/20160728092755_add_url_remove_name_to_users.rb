class AddUrlRemoveNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :avatar_url, :string
    add_column :users, :thumb_url, :string
    remove_column :users, :name, :string
  end
end
