module TeamController

  def get_teams
    {:data => @user.serialized_teams}
  end

  def get_team_by_id(id)
    result=Hash.new
    team=@user.teams.find(id) rescue nil;

    if team.nil?
      result[:error]={:msg => "Team not found"}
    else
      result[:data]=team.serialize
    end
    result
  end

  def create_team(params)
    result=Hash.new

    fields=Hash.new

    fields[:name]=params["name"]

    fields[:description]=params["description"]

    fields[:admin]=@user

    team=Team.create(fields)

    if team.errors.any?
      result[:error]=team.errors
    else
      @user.teams << team
      result[:data]=team.serialize

    end
    result

  end

  def change_team(id, params)
    result=Hash.new
    fields=Hash.new

    if params.include?("name")
      fields[:name]=params["name"]
    end

    if params.include?("description")
      fields[:description]=params["description"]
    end


    team=Team.find(id)

    team.update(fields)

    if team.errors.any?
      result[:error]=team.errors
    else
      result[:data]=team.serialize
    end

    result
  end

  def get_admin(team_id)
    admin=Team.find(team_id).serialized_admin
    {:data => admin}
  end

  def get_members(team_id)
    {:data => Team.find(team_id).serialized_members}
  end

  def get_meetings(team_id)
    {:data => Team.find(team_id).meetings}
  end

  def get_messages(team_id)
    {:data => Team.find(team_id).messages.map { |msg|
      TeamMessageSerializer.new(msg).attributes
    }}
  end
end