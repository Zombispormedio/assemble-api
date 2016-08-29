

#Team.find(1).meetings << Meeting.create(name:"festival")

user=User.find(66)

#user.chats[0].messages << Message.create(content: "hola")

Meeting.find(1).messages << MeetingMessage.create(content:"hola", sender: user)