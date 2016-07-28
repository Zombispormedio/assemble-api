class AddUrlToUsers < ActiveRecord::Migration
  def change
    add_column :users, :full_avatar_url, :string
    add_column :users, :large_avatar_url, :string
    add_column :users, :medium_avatar_url, :string
    add_column :users, :thumb_avatar_url, :string
    remove_column :users, :avatar_url, :string
    remove_column :users, :thumb_url, :string
  end
end
