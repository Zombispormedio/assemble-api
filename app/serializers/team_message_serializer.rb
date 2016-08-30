class TeamMessageSerializer < ActiveModel::Serializer
  attributes :id, :team_id, :content, :created_at, :sender

  def sender
    SenderSerializer.new(object.sender).attributes
  end


end