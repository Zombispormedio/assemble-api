

#Team.find(1).meetings << Meeting.create(name:"festival")

user=User.find(66)

#user.chats[0].messages << Message.create(content: "hola")

p user.messages
p Message.find(4).sender