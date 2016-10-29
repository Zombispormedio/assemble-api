class RenamePictureToClasses < ActiveRecord::Migration
  def change
    rename_column :teams, :full_avatar_url, :full_image_url
    rename_column :teams, :large_avatar_url, :large_image_url
    rename_column :teams, :medium_avatar_url, :medium_image_url
    rename_column :teams, :thumb_avatar_url, :thumb_image_url

    rename_column :meetings, :full_avatar_url, :full_image_url
    rename_column :meetings, :large_avatar_url, :large_image_url
    rename_column :meetings, :medium_avatar_url, :medium_image_url
    rename_column :meetings, :thumb_avatar_url, :thumb_image_url

  end
end
