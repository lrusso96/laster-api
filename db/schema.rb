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

ActiveRecord::Schema.define(version: 2019_07_21_150411) do

  create_table "albums", force: :cascade do |t|
    t.string "title"
    t.integer "artist_id"
    t.index ["artist_id"], name: "index_albums_on_artist_id"
  end

  create_table "artists", force: :cascade do |t|
    t.string "name"
  end

  create_table "images", force: :cascade do |t|
    t.string "size"
    t.string "url"
    t.integer "album_id"
    t.index ["album_id"], name: "index_images_on_album_id"
  end

  create_table "tracks", force: :cascade do |t|
    t.string "title"
    t.integer "artist_id"
    t.integer "album_id"
    t.string "image"
    t.index ["album_id"], name: "index_tracks_on_album_id"
    t.index ["artist_id"], name: "index_tracks_on_artist_id"
  end

end
