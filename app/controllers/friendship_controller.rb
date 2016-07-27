module FriendshipController

  def search_new_friends(search_text)
    friend_ids=@user.friends.select("id").map{|item| item.id}

    users=User.select("id, email, username, name")
              .where("(email LIKE ? OR username LIKE ? OR name LIKE ?) AND id NOT IN (?)",
                     "#{search_text}%", "#{search_text}%","#{search_text}%", friend_ids)


    {:data=>users}
  end

  def get_friends
    friends=@user.friends.select("friend_id, email, username, name")

    {:data=>friends}

  end

  def get_friend_by_id(id)
    friend=@user.friends.select("friend_id, email, username, name, birth_date, location, bio, sign_up_at").find(id)
    {:data=>friend}
  end

end



#user.friends.destroy( User.find(90))
#user.friends << User.find(90)
#user.friends.select("id")