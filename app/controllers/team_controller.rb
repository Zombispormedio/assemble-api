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
    fields=Hash.new

    if @body.include?("name")
      fields[:name]=@body["name"]
    end

    if @body.include?("description")
      fields[:description]=@body["description"]
    end


    team=Team.find(@team_id)

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
    team=Team.find(@team_id)
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
    admin=Team.find(@team_id).serialized_admin
    {:data => admin}
  end

  def change_admin
    result=Hash.new
    team=Team.find(@team_id)

    if @user.id != team.admin_id || @user.id==@admin_id
      result[:error]={:msg=>"You aren't admin"} if @user.id != team.admin_id
      result[:error]={:msg=>"You are admin yet"} if @user.id==@admin_id
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
      result[:error]={:msg=>"New admin is not member"}
    end

    result
  end

  def get_members
    {:data => Team.find(@team_id).serialized_members}
  end

  def add_members
    result=Hash.new
    team=Team.find(@team_id)
    if @user.id != team.admin_id
      result[:error]={:msg=>"You aren't admin"} if @user.id != team.admin_id
      return result
    end

    @new_members.each do |id|
      is_member=team.members.find(id) rescue nil;
      if is_member.nil?
        team.members << User.find(id)
      end
    end

    result[:data]=team.serialize

    result
  end

  def get_meetings
    {:data => Team.find(@team_id).meetings}
  end

  def get_messages
    {:data => Team.find(@team_id).messages.map { |msg|
      TeamMessageSerializer.new(msg).attributes
    }}
  end
end