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

ActiveRecord::Schema.define(version: 20161112205811) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ar_internal_metadata", primary_key: "key", id: :string, force: :cascade do |t|
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "artist_artist_groups", force: :cascade do |t|
    t.integer  "artist_id",       null: false
    t.integer  "artist_group_id", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["artist_group_id"], name: "index_artist_artist_groups_on_artist_group_id", using: :btree
    t.index ["artist_id", "artist_group_id"], name: "index_artist_artist_groups_on_join_uniqueness", unique: true, using: :btree
    t.index ["artist_id"], name: "index_artist_artist_groups_on_artist_id", using: :btree
  end

  create_table "artist_groups", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "artists", force: :cascade do |t|
    t.string   "name",               null: false
    t.string   "instagram_username"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "authentications", force: :cascade do |t|
    t.string   "provider",   null: false
    t.string   "uid",        null: false
    t.string   "token",      null: false
    t.string   "username"
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider", "uid"], name: "index_authentications_on_provider_and_uid", unique: true, using: :btree
    t.index ["user_id"], name: "index_authentications_on_user_id", using: :btree
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  end

  create_table "pendant_records", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "pendant_id", null: false
    t.integer  "photo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date     "worn_on",    null: false
    t.index ["created_at"], name: "index_pendant_records_on_created_at", using: :btree
    t.index ["pendant_id"], name: "index_pendant_records_on_pendant_id", using: :btree
    t.index ["photo_id"], name: "index_pendant_records_on_photo_id", using: :btree
    t.index ["user_id"], name: "index_pendant_records_on_user_id", using: :btree
  end

  create_table "pendants", force: :cascade do |t|
    t.string   "name",            null: false
    t.integer  "artist_id"
    t.integer  "user_id",         null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "artist_group_id"
    t.index ["artist_group_id"], name: "index_pendants_on_artist_group_id", using: :btree
    t.index ["artist_id"], name: "index_pendants_on_artist_id", using: :btree
    t.index ["user_id"], name: "index_pendants_on_user_id", using: :btree
  end

  create_table "photos", force: :cascade do |t|
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "user_id"
    t.string   "photo_file_name",    null: false
    t.string   "photo_content_type", null: false
    t.integer  "photo_file_size",    null: false
    t.datetime "photo_updated_at",   null: false
    t.boolean  "photo_processing"
    t.index ["user_id"], name: "index_photos_on_user_id", using: :btree
  end

  create_table "push_notification_subscriptions", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "endpoint",   null: false
    t.string   "p256dh",     null: false
    t.string   "auth",       null: false
    t.index ["endpoint", "p256dh", "auth"], name: "index_push_notification_subscriptions_on_data", unique: true, using: :btree
    t.index ["user_id"], name: "index_push_notification_subscriptions_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "email"
    t.string   "encrypted_password", limit: 128
    t.string   "confirmation_token", limit: 128
    t.string   "remember_token",     limit: 128, null: false
    t.string   "name"
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["remember_token"], name: "index_users_on_remember_token", using: :btree
  end

  add_foreign_key "artist_artist_groups", "artist_groups"
  add_foreign_key "artist_artist_groups", "artists"
  add_foreign_key "authentications", "users"
  add_foreign_key "pendant_records", "pendants"
  add_foreign_key "pendant_records", "photos"
  add_foreign_key "pendant_records", "users"
  add_foreign_key "pendants", "artist_groups"
  add_foreign_key "pendants", "artists"
  add_foreign_key "pendants", "users"
  add_foreign_key "photos", "users"
  add_foreign_key "push_notification_subscriptions", "users"

  create_view :pendant_searches,  sql_definition: <<-SQL
      SELECT pendants.id AS pendant_id,
      pendants.name AS term
     FROM pendants
  UNION
   SELECT pendants.id AS pendant_id,
      artists.name AS term
     FROM (pendants
       JOIN artists ON ((pendants.artist_id = artists.id)));
  SQL

end
