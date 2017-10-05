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

ActiveRecord::Schema.define(version: 20171004171550) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "doctor_appointments", force: :cascade do |t|
    t.text "description"
    t.datetime "from"
    t.datetime "to"
    t.bigint "doctor_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_id"], name: "index_doctor_appointments_on_doctor_id"
    t.index ["user_id"], name: "index_doctor_appointments_on_user_id"
  end

  create_table "doctors", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "city"
    t.string "username"
    t.string "password"
    t.text "address"
    t.string "primary_practice"
    t.string "secondary_practice"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "city"
    t.string "username"
    t.string "password"
    t.text "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
