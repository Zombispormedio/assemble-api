module TeamController
  include BaseController

  def get_teams
    {:data => @user.serialized_teams}
  end

  def get_team_by_id
    result=Hash.new
    team=@user.teams.find(@team_id) rescue nil;

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

  def change_team
    result=Hash.new
    team=@user.teams.find(@team_id) rescue nil;

    if team.nil?
      result[:error]={:msg => "Team not found"}
      return result
    end

    fields=Hash.new

    if @body.include?("name")
      fields[:name]=@body["name"]
    end

    if @body.include?("description")
      fields[:description]=@body["description"]
    end

    team.update(fields)

    if team.errors.any?
      result[:error]=team.errors
    else
      result[:data]=team.serialize
    end

    result
  end

  def upload_image
    result=Hash.new
    team=@user.teams.find(@team_id) rescue nil;

    if team.nil?
      result[:error]={:msg => "Team not found"}
      return result
    end
    image=upload(team.uid, @team_image)

    if image.nil?
      result[:error]={:msg => "No file selected"}
    else
      team.full_image_url=image.full
      team.large_image_url=image.large
      team.medium_image_url=image.medium
      team.thumb_image_url=image.thumb
      team.save
      image.clean
      if team.errors.any?
        result[:error]=team.errors
      else
        result[:data]=team.serialize
      end
    end
    result

  end

  def get_admin
    team=@user.teams.find(@team_id) rescue nil;

    if team.nil?
      result[:error]={:msg => "Team not found"}
      return result
    end
    admin=team.serialized_admin
    {:data => admin}
  end

  def change_admin
    result=Hash.new
    team=@user.teams.find(@team_id) rescue nil

    if team.nil?
      result[:error]={:msg => "Team not found"}
      return result
    end

    if @user.id != team.admin_id || @user.id==@admin_id
      result[:error]={:msg => "You aren't admin"} if @user.id != team.admin_id
      result[:error]={:msg => "You are admin yet"} if @user.id==@admin_id
      return result
    end

    new_admin= team.members.find(@admin_id) rescue nil;
    if new_admin
      team.admin=new_admin
      team.save
      if team.errors.any?
        result[:error]=team.errors
      else
        result[:data]=team.serialized_admin
      end
    else
      result[:error]={:msg => "New admin is not member"}
    end

    result
  end

  def get_members
    team=@user.teams.find(@team_id) rescue nil;

    if team.nil?
      return {:error => {:msg => "Team not found"}}
    end
    {:data => Team.find(@team_id).serialized_members}
  end

  def add_members
    result=Hash.new
    team=@user.teams.find(@team_id) rescue nil

    if @new_members.nil?
      result[:error]={:msg => "Params isn't correct"}
      return result
    end

    if team.nil?
      result[:error]={:msg => "Team not found"}
      return result
    end


   if @user.id != team.admin_id
      result[:error]={:msg => "You aren't admin"} if @user.id != team.admin_id
      return result
    end


    @new_members.each do |id|

      friend=@user.friends.find_by(id: id) rescue nil

      unless friend.nil?
        is_member=team.members.find(id) rescue nil;
        p is_member
        if is_member.nil?
          team.members << User.find(id)
          add_new_member_to_meeting(team, id)
        end
      end
    end


    result[:data]=team.serialize

    result
  end

  def add_new_member_to_meeting(team,id)
    membership=team.memberships.find_by(member_id:id) rescue nil
    team.meetings.each { |meeting| meeting.attendances.create( {attendant: membership})}
  end

  def delete_member
    result=Hash.new
    team=@user.teams.find(@team_id) rescue nil

    if team.nil?
      result[:error]={:msg => "Team not found"}
      return result
    end
    if @user.id != team.admin_id
      result[:error]={:msg => "You aren't admin"}
      return result
    end
    membership= Membership.find_by(member_id: @q_member) rescue nil;
    if not membership.nil?
      membership.destroy
      result[:data]=team.serialize
    else
      result[:error]={:msg => "Don't have that member"}
    end

    result
  end

  def leave_team
    result=Hash.new
    team=@user.teams.find(@team_id) rescue nil

    if team.nil?
      result[:error]={:msg => "Team not found"}
      return result
    end
    membership= Membership.find_by(member_id: @user.id) rescue nil;
    if membership.nil?
      result[:error]={:msg => "Don't have that member"}
      return result
    end
    membership.destroy
    if @user.id == team.admin_id
      if team.members.length>0
        team.admin=team.members.first
        result[:data]={:msg => "You have left the team and it has assigned other admin"}
      else
        team.destroy
        result[:data]={:msg => "You have left the team and it has removed it"}
      end
    else
      result[:data]={:msg => "You have left the team"}
    end

    result
  end

  def get_meetings
    team=@user.teams.find(@team_id) rescue nil;

    if team.nil?
      return {:error => {:msg => "Team not found"}}
    end
    {:data => team.serialized_meetings}
  end

  def create_meeting_for_team
    result=Hash.new
    team=@user.teams.find(@team_id) rescue nil

    if team.nil?
      result[:error]={:msg => "Team not found"}
      return result
    end

    fields=Hash.new

    if @body.include?("name")
      fields[:name]=@body["name"]
    end

    if @body.include?("description")
      fields[:description]=@body["description"]
    end

    if @body.include?("day")
      fields[:day]=@body["day"]
    end

    if @body.include?("start_hour")
      fields[:start_hour]=@body["start_hour"]
    end

    if @body.include?("end_hour")
      fields[:end_hour]=@body["end_hour"]
    end

    meeting=team.meetings.create(fields)

    if meeting.errors.any?
      result[:error]=meeting.errors
    else
      result[:data]=meeting.serialize
    end

    result
  end

  def get_messages
    {:data => Team.find(@team_id).messages.map { |msg|
      TeamMessageSerializer.new(msg).attributes
    }}
  end
end