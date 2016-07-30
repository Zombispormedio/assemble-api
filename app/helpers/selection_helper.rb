class Selection

  cattr_reader :DEFAULT_USER
  @@COMPLETE_FIELDS_USER="email, username, birth_date, location, bio, sign_up_at, full_avatar_url, large_avatar_url, medium_avatar_url, thumb_avatar_url"

  cattr_reader :PROFILE
  @@PROFILE="id, "+ @@COMPLETE_FIELDS_USER

  cattr_reader :USER
  @@USER="id, email, username"


  cattr_reader :FRIEND
  @@FRIEND="friend_id, email, username"


  cattr_reader :FRIEND_BY_ID
  @@FRIEND_BY_ID="friend_id, "+ @@COMPLETE_FIELDS_USER


  cattr_reader :FRIEND_REQUEST
  @@FRIEND_REQUEST="friend_request_id, email, username"


  cattr_reader :FRIEND_REQUEST_BY_ID
  @@FRIEND_REQUEST_BY_ID="friend_request_id, "+@@COMPLETE_FIELDS_USER

end