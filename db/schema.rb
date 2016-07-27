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

ActiveRecord::Schema.define(version: 20160727205206) do

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

  create_table "friendship_requests", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "friend_request_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "uid",                default: "", null: false
    t.string   "email",              default: "", null: false
    t.string   "password",           default: "", null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.datetime "sign_up_at"
    t.string   "username"
    t.string   "name"
    t.datetime "birth_date"
    t.string   "location"
    t.string   "bio"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["uid"], name: "index_users_on_uid", using: :btree
    t.index ["username"], name: "index_users_on_username", using: :btree
  end

end
