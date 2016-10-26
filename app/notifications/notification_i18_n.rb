module NotificationI18N

  #Templates
  MESSAGE={
      android_group: "message",
      android_group_message: {
          es: "$[notif_count] new messages",
          en: "$[notif_count] mensajes nuevos"
      },
      small_icon: "logo",
      android_accent_color: "2196f3",
      data: {
          type: "message"
      }
  }

  READ_MESSAGE={
      android_group: "read_message",
      contents:{es:"read_message"},
      data: {
          type: "read_message"
      }
  }

  FRIEND_REQUEST={
      android_group: "friend_request",
      android_group_message: {
          es: "$[notif_count] new friend requests",
          en: "$[notif_count] peticiones de amistad"
      },
      contents:{en:"#{friend} sent you a friend request", es:"#{friend} te ha enviado una petición de amistad"},

      small_icon: "logo",
      android_accent_color: "2196f3",
      data: {
          type: "friend_request"
      }
  }


  ACCEPTED_FRIEND_REQUEST={
      android_group: "accepted_friend_request",
      android_group_message: {
          es: "$[notif_count] accepted friend requets",
          en: "$[notif_count] peticiones de amistad aceptadas"
      },
      contents:{en:"#{friend} accepted your friend request", es:"#{friend} ha aceptado tu petición de amistad"},
      small_icon: "logo",
      android_accent_color: "2196f3",
      data: {
          type: "accepted_friend_request"
      }
  }


  CREATED_TEAM={
      android_group: "created_team",
      android_group_message: {
          es: "$[notif_count] created teams",
          en: "$[notif_count] equipos creados"
      },
      contents:{en:"#{friend} created #{team} team", es:"#{friend} ha creado el equipo #{team}"},
      small_icon: "logo",
      android_accent_color: "2196f3",
      data: {
          type: "created_team"
      }
  }

  CREATED_MEETING={
      android_group: "created_meeting",
      android_group_message: {
          es: "$[notif_count] created meetings",
          en: "$[notif_count] reuniones creadas"
      },
      contents:{en:"#{team} created #{meeting} meeting for #{date}", es:"#{team} have creado la reunión #{meeting} para el #{date}"},
      small_icon: "logo",
      android_accent_color: "2196f3",
      data: {
          type: "created_meeting"
      }
  }



end