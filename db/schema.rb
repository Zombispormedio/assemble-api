# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161023145526) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"
  enable_extension "pg_trgm"
  enable_extension "citext"
  enable_extension "fuzzystrmatch"
  enable_extension "intarray"
  enable_extension "xml2"
  enable_extension "uuid-ossp"
  enable_extension "btree_gist"
  enable_extension "pgcrypto"
  enable_extension "btree_gin"
  enable_extension "cube"
  enable_extension "dict_int"
  enable_extension "dblink"
  enable_extension "pgrowlocks"
  enable_extension "ltree"
  enable_extension "dict_xsyn"
  enable_extension "unaccent"
  enable_extension "tablefunc"
  enable_extension "earthdistance"
  enable_extension "pgstattuple"
  enable_extension "pg_stat_statements"
  enable_extension "plv8"

  create_table "attendances", force: :cascade do |t|
    t.integer  "meeting_id"
    t.integer  "membership_id"
    t.boolean  "attend?"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "chats", force: :cascade do |t|
    t.integer  "owner_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["friend_id"], name: "index_chats_on_friend_id", using: :btree
    t.index ["owner_id"], name: "index_chats_on_owner_id", using: :btree
  end

  create_table "friendship_requests", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "friend_request_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["friend_request_id"], name: "index_friendship_requests_on_friend_request_id", using: :btree
    t.index ["user_id"], name: "index_friendship_requests_on_user_id", using: :btree
  end

  create_table "friendships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["friend_id"], name: "index_friendships_on_friend_id", using: :btree
    t.index ["user_id"], name: "index_friendships_on_user_id", using: :btree
  end

  create_table "incomings", force: :cascade do |t|
    t.integer  "chat_id"
    t.integer  "sender_id"
    t.integer  "message_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["chat_id"], name: "index_incomings_on_chat_id", using: :btree
    t.index ["message_id"], name: "index_incomings_on_message_id", using: :btree
    t.index ["sender_id"], name: "index_incomings_on_sender_id", using: :btree
  end

  create_table "meeting_messages", force: :cascade do |t|
    t.integer  "meeting_id"
    t.integer  "sender_id"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uid"
  end

  create_table "meetings", force: :cascade do |t|
    t.integer  "team_id"
    t.string   "name"
    t.string   "description"
    t.datetime "start_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "full_image_url"
    t.string   "large_image_url"
    t.string   "medium_image_url"
    t.string   "thumb_image_url"
    t.string   "uid"
    t.datetime "end_at"
    t.index ["team_id"], name: "index_meetings_on_team_id", using: :btree
  end

  create_table "memberships", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "member_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["member_id"], name: "index_memberships_on_member_id", using: :btree
    t.index ["team_id"], name: "index_memberships_on_team_id", using: :btree
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_read"
    t.boolean  "is_sent"
    t.boolean  "is_delivered"
    t.string   "uid"
  end

  create_table "team_messages", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "sender_id"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uid"
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "admin_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "full_image_url"
    t.string   "large_image_url"
    t.string   "medium_image_url"
    t.string   "thumb_image_url"
    t.string   "uid"
    t.index ["admin_id"], name: "index_teams_on_admin_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "uid",                default: "", null: false
    t.string   "email",              default: "", null: false
    t.string   "password",           default: "", null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.datetime "sign_up_at"
    t.string   "username"
    t.datetime "birth_date"
    t.string   "location"
    t.string   "bio"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "full_avatar_url"
    t.string   "large_avatar_url"
    t.string   "medium_avatar_url"
    t.string   "thumb_avatar_url"
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["uid"], name: "index_users_on_uid", using: :btree
    t.index ["username"], name: "index_users_on_username", using: :btree
  end

end
