#Team.find(7).meetings.create(name:"Cafetito", day:"2016-09-16T11:20:10.523Z")

#User.find(66).teams.create(name:"sudorosos")

#Meeting.all.each{|item| item.update(end_at:"2016-09-16T20:20:10.523Z")}


#User.find(66).chats.create(friend: User.find(117))

#User.find(66).chats.find_by(friend_id: 117).messages.create(content: "hello 117")

#User.find(117).chats.find_by(friend_id: 66).messages.create(content: "hello 66")

#User.find(66).chats.first.destroy

user=User.find(66)


(90..117).each do |id|
  friend=user.friends.find_by(id: id) rescue nil
  if friend.nil?
    req=User.find(id)
    user.friend_requests<<req
  end
end