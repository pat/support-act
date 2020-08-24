# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_24_121128) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: :cascade do |t|
    t.uuid "identifier", null: false
    t.string "name", null: false
    t.string "last_fm_url"
    t.string "mbid"
    t.jsonb "images", default: {}, null: false
    t.bigint "artist_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.jsonb "raw", default: {}, null: false
    t.string "image"
    t.string "spotify_url"
    t.index ["artist_id"], name: "index_albums_on_artist_id"
    t.index ["identifier"], name: "index_albums_on_identifier", unique: true
    t.index ["last_fm_url"], name: "index_albums_on_last_fm_url"
  end

  create_table "artists", force: :cascade do |t|
    t.uuid "identifier", null: false
    t.string "name", null: false
    t.string "last_fm_url"
    t.string "mbid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.jsonb "raw", default: {}, null: false
    t.string "spotify_url"
    t.index ["identifier"], name: "index_artists_on_identifier", unique: true
    t.index ["last_fm_url"], name: "index_artists_on_last_fm_url"
  end

  create_table "fans", force: :cascade do |t|
    t.uuid "identifier", null: false
    t.string "provider"
    t.string "provider_identity"
    t.jsonb "provider_cache", default: {}, null: false
    t.string "email", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["confirmation_token"], name: "index_fans_on_confirmation_token", unique: true
    t.index ["email"], name: "index_fans_on_email", unique: true
    t.index ["identifier"], name: "index_fans_on_identifier", unique: true
    t.index ["reset_password_token"], name: "index_fans_on_reset_password_token", unique: true
  end

  create_table "purchases", force: :cascade do |t|
    t.bigint "album_id", null: false
    t.bigint "fan_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["album_id"], name: "index_purchases_on_album_id"
    t.index ["fan_id", "album_id"], name: "index_purchases_on_fan_id_and_album_id", unique: true
    t.index ["fan_id"], name: "index_purchases_on_fan_id"
  end

  add_foreign_key "albums", "artists"
  add_foreign_key "purchases", "albums"
  add_foreign_key "purchases", "fans"
end
