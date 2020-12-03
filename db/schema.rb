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

ActiveRecord::Schema.define(version: 2020_11_28_062444) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "item_id", null: false
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item_id"], name: "index_comments_on_item_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "flight_details", force: :cascade do |t|
    t.string "airline"
    t.string "flight_number"
    t.bigint "item_id"
    t.string "departure_airport"
    t.string "arrival_airport"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item_id"], name: "index_flight_details_on_item_id"
  end

  create_table "guests", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "trip_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["trip_id"], name: "index_guests_on_trip_id"
    t.index ["user_id"], name: "index_guests_on_user_id"
  end

  create_table "items", force: :cascade do |t|
    t.bigint "trip_id", null: false
    t.bigint "user_id", null: false
    t.string "name"
    t.date "start_date"
    t.date "end_date"
    t.string "address"
    t.string "status"
    t.integer "price"
    t.string "url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "type"
    t.string "category"
    t.index ["trip_id"], name: "index_items_on_trip_id"
    t.index ["user_id"], name: "index_items_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "content"
    t.bigint "trip_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["trip_id"], name: "index_messages_on_trip_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "item_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item_id"], name: "index_tasks_on_item_id"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "trips", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.date "start_date"
    t.date "end_date"
    t.string "location"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "invite_token"
    t.index ["user_id"], name: "index_trips_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name", default: "", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "item_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item_id"], name: "index_votes_on_item_id"
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

  add_foreign_key "comments", "items"
  add_foreign_key "comments", "users"
  add_foreign_key "guests", "trips"
  add_foreign_key "guests", "users"
  add_foreign_key "items", "trips"
  add_foreign_key "items", "users"
  add_foreign_key "messages", "trips"
  add_foreign_key "messages", "users"
  add_foreign_key "trips", "users"
  add_foreign_key "votes", "items"
  add_foreign_key "votes", "users"
end
