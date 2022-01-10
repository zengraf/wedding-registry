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

ActiveRecord::Schema.define(version: 2022_01_03_173259) do

  create_table "halls", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.string "phone_number"
    t.date "date"
    t.decimal "deposit", precision: 10, scale: 2
    t.boolean "confirmed", default: false
    t.integer "added_by_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "hall_id", null: false
    t.index ["added_by_id"], name: "index_orders_on_added_by_id"
    t.index ["hall_id"], name: "index_orders_on_hall_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "name"
    t.integer "order_id", null: false
    t.text "description"
    t.datetime "start_time", null: false
    t.datetime "end_time"
    t.decimal "actual_price", precision: 8, scale: 2
    t.decimal "price", precision: 8, scale: 2, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_tasks_on_order_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.string "email"
    t.string "phone_number"
    t.integer "role", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
  end

  add_foreign_key "orders", "users", column: "added_by_id"
  add_foreign_key "tasks", "orders"
end
