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

ActiveRecord::Schema.define(version: 2018_11_27_093006) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "poster_ips", force: :cascade do |t|
    t.string "ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "poster_ips_users", id: false, force: :cascade do |t|
    t.bigint "poster_ip_id", null: false
    t.bigint "user_id", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.bigint "user_id"
    t.string "header"
    t.text "content"
    t.string "ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "poster_ip_id"
    t.integer "ratings_count", default: 0
    t.float "rating_sum", default: 0.0
    t.index ["ip"], name: "index_posts_on_ip"
    t.index ["poster_ip_id"], name: "index_posts_on_poster_ip_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.bigint "post_id"
    t.integer "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_ratings_on_post_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "login"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "posts", "poster_ips"
  add_foreign_key "posts", "users"
  add_foreign_key "ratings", "posts"
end
