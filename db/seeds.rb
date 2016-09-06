
#Team.find(7).meetings.create(name:"Cafetito", day:"2016-09-16T11:20:10.523Z")

#User.find(66).teams.create(name:"sudorosos")

Meeting.all.each{|item| item.update(end_at:"2016-09-16T20:20:10.523Z")}