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

ActiveRecord::Schema[7.1].define(version: 2025_04_15_113340) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "coffee_records", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "origin"
    t.string "bean_type"
    t.string "process_method", null: false
    t.string "roast_level", null: false
    t.string "acidity_level", null: false
    t.string "body_level", null: false
    t.text "notes"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "product_name"
    t.string "name"
    t.string "variety"
    t.string "process"
    t.string "roast"
    t.string "acidity"
    t.string "body"
    t.index ["user_id"], name: "index_coffee_records_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "coffee_records", "users"
end
