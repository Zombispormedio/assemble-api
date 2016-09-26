class TeamSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :admin, :members, :created_at, :full_image_url, :large_image_url, :medium_image_url, :thumb_image_url

  def members
    object.serialized_members
  end

  def admin
    object.serialized_admin
  end
end