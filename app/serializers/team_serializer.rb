class TeamSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :members, :created_at, :full_image_url, :large_image_url, :medium_image_url, :thumb_image_url

  def members
    object.members.map{|member|
      result=MemberSerializer.new(member).attributes

      if result[:id]==object.admin_id
        result[:admin]=true
      end
      result
    }
  end
end