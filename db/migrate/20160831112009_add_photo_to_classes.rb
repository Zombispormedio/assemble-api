class AddPhotoToClasses < ActiveRecord::Migration
  def change
    add_column :teams, :full_avatar_url, :string
    add_column :teams, :large_avatar_url, :string
    add_column :teams, :medium_avatar_url, :string
    add_column :teams, :thumb_avatar_url, :string

    add_column :meetings, :full_avatar_url, :string
    add_column :meetings, :large_avatar_url, :string
    add_column :meetings, :medium_avatar_url, :string
    add_column :meetings, :thumb_avatar_url, :string
  end
end
