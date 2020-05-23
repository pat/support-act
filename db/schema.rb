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

ActiveRecord::Schema.define(version: 2020_05_23_140648) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: :cascade do |t|
    t.uuid "identifier", null: false
    t.string "name", null: false
    t.string "url", null: false
    t.string "mbid"
    t.jsonb "images", default: {}, null: false
    t.bigint "artist_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["artist_id"], name: "index_albums_on_artist_id"
    t.index ["identifier"], name: "index_albums_on_identifier", unique: true
    t.index ["url"], name: "index_albums_on_url"
  end

  create_table "artists", force: :cascade do |t|
    t.uuid "identifier", null: false
    t.string "name", null: false
    t.string "url", null: false
    t.string "mbid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["identifier"], name: "index_artists_on_identifier", unique: true
    t.index ["url"], name: "index_artists_on_url"
  end

  create_table "fans", force: :cascade do |t|
    t.uuid "identifier", null: false
    t.string "provider", null: false
    t.string "provider_identity", null: false
    t.jsonb "provider_cache", default: {}, null: false
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["identifier"], name: "index_fans_on_identifier", unique: true
  end

  create_table "purchases", force: :cascade do |t|
    t.bigint "album_id", null: false
    t.bigint "fan_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["album_id"], name: "index_purchases_on_album_id"
    t.index ["fan_id"], name: "index_purchases_on_fan_id"
  end

  add_foreign_key "albums", "artists"
  add_foreign_key "purchases", "albums"
  add_foreign_key "purchases", "fans"
end
