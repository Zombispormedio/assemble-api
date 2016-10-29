#Team.find(7).meetings.create(name:"Cafetito", day:"2016-09-16T11:20:10.523Z")

#User.find(66).teams.create(name:"sudorosos")

#Meeting.all.each{|item| item.update(end_at:"2016-09-16T20:20:10.523Z")}


#User.find(66).chats.create(friend: User.find(117))

#User.find(66).chats.find_by(friend_id: 117).messages.create(content: "hello 117")

#User.find(117).chats.find_by(friend_id: 66).messages.create(content: "hello 66")

#User.find(66).chats.first.destroy
#chat=User.find(66).chats.find(11)

#chat.messages.create(content: "Mierda!!!!" , is_sent: true)

user=User.find(66)

#user.starreds.create(team_id: 16)

#user.bookmarks.create(meeting_id: 45)

p user.starreds

p user.bookmarks

p Meeting.find(45).attendants.find_by(member_id:66)

p user.starreds.map{|star|star.team_id}.include? 16