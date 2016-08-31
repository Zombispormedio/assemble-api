module TeamController

  def get_teams
    {:data => @user.teams}
  end

  def get_team_by_id(id)
    result=Hash.new
    team=@user.teams.find(id) rescue nil;

   if team.nil?
     result[:error]={:msg => "Team not found"}
   else
     result[:data]=TeamSerializer.new(team).attributes
   end
    result
  end

  def get_admin(team_id)
    {:data => Team.find(team_id).admin}
  end

  def get_members(team_id)
    {:data => Team.find(team_id).members}
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