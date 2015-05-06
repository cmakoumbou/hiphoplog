# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150505083500) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: :cascade do |t|
    t.string   "name"
    t.string   "key"
    t.datetime "published_at"
    t.integer  "channel_id"
    t.integer  "artist_id"
    t.string   "external_image"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.boolean  "explicit"
  end

  add_index "albums", ["artist_id"], name: "index_albums_on_artist_id", using: :btree
  add_index "albums", ["channel_id"], name: "index_albums_on_channel_id", using: :btree

  create_table "artists", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "channels", force: :cascade do |t|
    t.string   "url"
    t.integer  "count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "artist_id"
    t.boolean  "multi"
    t.string   "provider"
  end

  add_index "channels", ["artist_id"], name: "index_channels_on_artist_id", using: :btree

  create_table "songs", force: :cascade do |t|
    t.string   "name"
    t.string   "key"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "channel_id"
    t.datetime "published_at"
    t.integer  "artist_id"
    t.string   "external_url"
    t.string   "external_image"
  end

  add_index "songs", ["artist_id"], name: "index_songs_on_artist_id", using: :btree
  add_index "songs", ["channel_id"], name: "index_songs_on_channel_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                  default: false
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "videos", force: :cascade do |t|
    t.string   "name"
    t.string   "key"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "channel_id"
    t.datetime "published_at"
    t.integer  "artist_id"
  end

  add_index "videos", ["artist_id"], name: "index_videos_on_artist_id", using: :btree
  add_index "videos", ["channel_id"], name: "index_videos_on_channel_id", using: :btree

  add_foreign_key "albums", "artists"
  add_foreign_key "albums", "channels"
  add_foreign_key "channels", "artists"
  add_foreign_key "songs", "artists"
  add_foreign_key "songs", "channels"
  add_foreign_key "videos", "artists"
  add_foreign_key "videos", "channels"
end
