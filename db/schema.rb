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

ActiveRecord::Schema.define(version: 20171008020701) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artist_artist_groups", id: :serial, force: :cascade do |t|
    t.integer "artist_id", null: false
    t.integer "artist_group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_group_id"], name: "index_artist_artist_groups_on_artist_group_id"
    t.index ["artist_id", "artist_group_id"], name: "index_artist_artist_groups_on_join_uniqueness", unique: true
    t.index ["artist_id"], name: "index_artist_artist_groups_on_artist_id"
  end

  create_table "artist_groups", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "artists", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.string "instagram_username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "authentications", id: :serial, force: :cascade do |t|
    t.string "provider", null: false
    t.string "uid", null: false
    t.string "token", null: false
    t.string "username"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider", "uid"], name: "index_authentications_on_provider_and_uid", unique: true
    t.index ["user_id"], name: "index_authentications_on_user_id"
  end

  create_table "collection_owners", id: :serial, force: :cascade do |t|
    t.integer "collection_id", null: false
    t.integer "owner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["collection_id"], name: "index_collection_owners_on_collection_id"
    t.index ["owner_id"], name: "index_collection_owners_on_owner_id"
  end

  create_table "collections", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "colors", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.integer "artist_group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sample_photo_id"
    t.index ["artist_group_id"], name: "index_colors_on_artist_group_id"
    t.index ["sample_photo_id"], name: "index_colors_on_sample_photo_id", unique: true
  end

  create_table "delayed_jobs", id: :serial, force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "glass_art_piece_colors", id: :serial, force: :cascade do |t|
    t.integer "glass_art_piece_id", null: false
    t.integer "color_id", null: false
    t.index ["color_id"], name: "index_glass_art_piece_colors_on_color_id"
    t.index ["glass_art_piece_id", "color_id"], name: "index_glass_art_piece_colors_on_glass_art_piece_id_and_color_id", unique: true
    t.index ["glass_art_piece_id"], name: "index_glass_art_piece_colors_on_glass_art_piece_id"
  end

  create_table "glass_art_pieces", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "artist_group_id", null: false
    t.integer "collection_id"
    t.boolean "wearable", default: false, null: false
    t.index ["artist_group_id"], name: "index_glass_art_pieces_on_artist_group_id"
    t.index ["collection_id"], name: "index_glass_art_pieces_on_collection_id"
  end

  create_table "pendant_records", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "pendant_id", null: false
    t.integer "photo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "worn_on", null: false
    t.index ["created_at"], name: "index_pendant_records_on_created_at"
    t.index ["pendant_id"], name: "index_pendant_records_on_pendant_id"
    t.index ["photo_id"], name: "index_pendant_records_on_photo_id"
    t.index ["user_id"], name: "index_pendant_records_on_user_id"
  end

  create_table "photos", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.string "photo_file_name", null: false
    t.string "photo_content_type", null: false
    t.integer "photo_file_size", null: false
    t.datetime "photo_updated_at", null: false
    t.boolean "photo_processing"
    t.index ["user_id"], name: "index_photos_on_user_id"
  end

  create_table "push_notification_subscriptions", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "endpoint", null: false
    t.string "p256dh", null: false
    t.string "auth", null: false
    t.index ["endpoint", "p256dh", "auth"], name: "index_push_notification_subscriptions_on_data", unique: true
    t.index ["user_id"], name: "index_push_notification_subscriptions_on_user_id"
  end

  create_table "u2f_registrations", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "key_handle", null: false
    t.string "public_key", null: false
    t.string "certificate", null: false
    t.integer "counter", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_u2f_registrations_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "encrypted_password", limit: 128
    t.string "confirmation_token", limit: 128
    t.string "remember_token", limit: 128, null: false
    t.string "name"
    t.index ["email"], name: "index_users_on_email"
    t.index ["remember_token"], name: "index_users_on_remember_token"
  end

  add_foreign_key "artist_artist_groups", "artist_groups"
  add_foreign_key "artist_artist_groups", "artists"
  add_foreign_key "authentications", "users"
  add_foreign_key "collection_owners", "collections"
  add_foreign_key "collection_owners", "users", column: "owner_id"
  add_foreign_key "colors", "artist_groups"
  add_foreign_key "colors", "photos", column: "sample_photo_id"
  add_foreign_key "glass_art_piece_colors", "colors"
  add_foreign_key "glass_art_piece_colors", "glass_art_pieces"
  add_foreign_key "glass_art_pieces", "artist_groups"
  add_foreign_key "glass_art_pieces", "collections"
  add_foreign_key "pendant_records", "glass_art_pieces", column: "pendant_id"
  add_foreign_key "pendant_records", "photos"
  add_foreign_key "pendant_records", "users"
  add_foreign_key "photos", "users"
  add_foreign_key "push_notification_subscriptions", "users"
  add_foreign_key "u2f_registrations", "users"

  create_view "artist_group_artists",  sql_definition: <<-SQL
      SELECT artist_groups.id AS artist_group_id,
      array_agg(artist_artist_groups.artist_id ORDER BY artist_artist_groups.artist_id) AS artist_ids
     FROM (artist_groups
       JOIN artist_artist_groups ON ((artist_artist_groups.artist_group_id = artist_groups.id)))
    GROUP BY artist_groups.id;
  SQL

  create_view "pendant_searches",  sql_definition: <<-SQL
      SELECT glass_art_pieces.id AS glass_art_piece_id,
      glass_art_pieces.name AS term
     FROM glass_art_pieces
    WHERE (glass_art_pieces.wearable = true)
  UNION
   SELECT glass_art_pieces.id AS glass_art_piece_id,
      artists.name AS term
     FROM ((glass_art_pieces
       JOIN artist_artist_groups ON ((glass_art_pieces.artist_group_id = artist_artist_groups.artist_group_id)))
       JOIN artists ON ((artist_artist_groups.artist_id = artists.id)))
    WHERE (glass_art_pieces.wearable = true);
  SQL

end
