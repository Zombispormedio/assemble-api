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
      contents:{en:"%s sent you a friend request", es:"%s te ha enviado una petición de amistad"},

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
      contents:{en:"%s accepted your friend request", es:"%s ha aceptado tu petición de amistad"},
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
      contents:{en:"%s created %s team", es:"%s ha creado el equipo %s"},
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
      contents:{en:"%s created %s meeting for %s", es:"%s have creado la reunión %s para el %s"},
      small_icon: "logo",
      android_accent_color: "2196f3",
      data: {
          type: "created_meeting"
      }
  }



end