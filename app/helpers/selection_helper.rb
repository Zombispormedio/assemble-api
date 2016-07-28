class Selection

  cattr_reader :PROFILE
  @@PROFILE="id, email, username, birth_date, location, bio"

  cattr_reader :USER
  @@USER="id, email, username"


  cattr_reader :FRIEND
  @@FRIEND="friend_id, email, username"


  cattr_reader :FRIEND_BY_ID
  @@FRIEND_BY_ID="friend_id, email, username, birth_date, location, bio, sign_up_at"


  cattr_reader :FRIEND_REQUEST
  @@FRIEND_REQUEST="friend_request_id, email, username"


  cattr_reader :FRIEND_REQUEST_BY_ID
  @@FRIEND_REQUEST_BY_ID="friend_request_id, email, username, birth_date, location, bio, sign_up_at"

end