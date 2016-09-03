

#Team.find(1).meetings << Meeting.create(name:"festival")

#user=User.find(66)

#p user.teams

#user.chats[0].messages << Message.create(content: "hola")

#Meeting.find(1).messages << MeetingMessage.create(content:"hola", sender: user)

#Team.find(4).members << User.find(98)

#Team.find(6).meetings.create(name:"festival")
#p Team.find(1).memberships

#p Meeting.find(36).attendants.find_by(member_id: 66).member



meeting=Meeting.find(39)

ar_attendants=meeting.attendants.to_ary
ar_attendances=meeting.attendances.to_ary

combination=ar_attendants.zip(ar_attendances)

combination.each do |membership, attendance|
  p membership.member
  p attendance.attendant
end
