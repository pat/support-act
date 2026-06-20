# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_06_20_032751) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "albums", force: :cascade do |t|
    t.bigint "artist_id", null: false
    t.datetime "created_at", null: false
    t.uuid "identifier", null: false
    t.string "image"
    t.jsonb "images", default: {}, null: false
    t.jsonb "last_fm_raw", default: {}, null: false
    t.string "last_fm_url"
    t.json "links", default: {}, null: false
    t.string "mbid"
    t.string "name", null: false
    t.jsonb "spotify_raw", default: {}, null: false
    t.string "spotify_url"
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_albums_on_artist_id"
    t.index ["identifier"], name: "index_albums_on_identifier", unique: true
    t.index ["last_fm_url"], name: "index_albums_on_last_fm_url"
    t.index ["mbid"], name: "index_albums_on_mbid"
    t.index ["spotify_url"], name: "index_albums_on_spotify_url"
  end

  create_table "artists", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.uuid "identifier", null: false
    t.jsonb "last_fm_raw", default: {}, null: false
    t.string "last_fm_url"
    t.json "links", default: {}, null: false
    t.string "mbid"
    t.string "name", null: false
    t.jsonb "spotify_raw", default: {}, null: false
    t.string "spotify_url"
    t.datetime "updated_at", null: false
    t.index ["identifier"], name: "index_artists_on_identifier", unique: true
    t.index ["last_fm_url"], name: "index_artists_on_last_fm_url"
    t.index ["mbid"], name: "index_artists_on_mbid"
    t.index ["spotify_url"], name: "index_artists_on_spotify_url"
  end

  create_table "fans", force: :cascade do |t|
    t.boolean "active", default: true, null: false
    t.datetime "confirmation_sent_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "created_at", null: false
    t.datetime "current_sign_in_at"
    t.inet "current_sign_in_ip"
    t.string "email", null: false
    t.string "encrypted_password", default: "", null: false
    t.uuid "identifier", null: false
    t.datetime "last_sign_in_at"
    t.inet "last_sign_in_ip"
    t.string "provider"
    t.jsonb "provider_cache", default: {}, null: false
    t.string "provider_identity"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.integer "sign_in_count", default: 0, null: false
    t.boolean "subscribed", default: true, null: false
    t.string "unconfirmed_email"
    t.datetime "updated_at", null: false
    t.index ["active"], name: "index_fans_on_active"
    t.index ["confirmation_token"], name: "index_fans_on_confirmation_token", unique: true
    t.index ["email"], name: "index_fans_on_email", unique: true
    t.index ["identifier"], name: "index_fans_on_identifier", unique: true
    t.index ["reset_password_token"], name: "index_fans_on_reset_password_token", unique: true
    t.index ["subscribed"], name: "index_fans_on_subscribed"
  end

  create_table "purchases", force: :cascade do |t|
    t.bigint "album_id", null: false
    t.datetime "created_at", null: false
    t.bigint "fan_id", null: false
    t.datetime "updated_at", null: false
    t.index ["album_id"], name: "index_purchases_on_album_id"
    t.index ["fan_id", "album_id"], name: "index_purchases_on_fan_id_and_album_id", unique: true
    t.index ["fan_id"], name: "index_purchases_on_fan_id"
  end

  create_table "service_checks", force: :cascade do |t|
    t.bigint "checkable_id", null: false
    t.string "checkable_type", default: "Album"
    t.datetime "created_at", null: false
    t.datetime "last_checked_at", null: false
    t.string "service", null: false
    t.datetime "updated_at", null: false
    t.index ["checkable_id", "checkable_type"], name: "index_service_checks_on_checkable"
  end

  add_foreign_key "albums", "artists"
  add_foreign_key "purchases", "albums"
  add_foreign_key "purchases", "fans"
end
