# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160405212632) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bars", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "boards", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "boxes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "elevations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "equipment", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "equipment_exercises", id: false, force: :cascade do |t|
    t.integer "exercise_id",  null: false
    t.integer "equipment_id", null: false
  end

  add_index "equipment_exercises", ["equipment_id", "exercise_id"], name: "index_Equipment_Exercises_on_equipment_id_and_exercise_id", using: :btree
  add_index "equipment_exercises", ["exercise_id", "equipment_id"], name: "index_Equipment_Exercises_on_exercise_id_and_equipment_id", using: :btree

  create_table "exercisemethods", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exercises", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "bar_id"
    t.integer  "board_id"
    t.integer  "box_id"
    t.integer  "elevation_id"
    t.integer  "exercisemethod_id"
    t.integer  "machine_id"
    t.integer  "movement_id"
    t.integer  "position_id"
    t.integer  "reprange_id"
    t.integer  "tempo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exercises_tensions", id: false, force: :cascade do |t|
    t.integer "exercise_id", null: false
    t.integer "tension_id",  null: false
  end

  add_index "exercises_tensions", ["exercise_id", "tension_id"], name: "index_Exercises_Tensions_on_exercise_id_and_tension_id", using: :btree
  add_index "exercises_tensions", ["tension_id", "exercise_id"], name: "index_Exercises_Tensions_on_tension_id_and_exercise_id", using: :btree

  create_table "exercises_weaknesses", id: false, force: :cascade do |t|
    t.integer "exercise_id", null: false
    t.integer "weakness_id", null: false
  end

  add_index "exercises_weaknesses", ["exercise_id", "weakness_id"], name: "index_Exercises_Weaknesses_on_exercise_id_and_weakness_id", using: :btree
  add_index "exercises_weaknesses", ["weakness_id", "exercise_id"], name: "index_Exercises_Weaknesses_on_weakness_id_and_exercise_id", using: :btree

  create_table "exercises_workouts", id: false, force: :cascade do |t|
    t.integer "workout_id",  null: false
    t.integer "exercise_id", null: false
  end

  add_index "exercises_workouts", ["exercise_id", "workout_id"], name: "index_exercises_workouts_on_exercise_id_and_workout_id", using: :btree
  add_index "exercises_workouts", ["workout_id", "exercise_id"], name: "index_exercises_workouts_on_workout_id_and_exercise_id", using: :btree

  create_table "machines", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "macrocycles", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "length"
    t.string   "macrocycle_type"
    t.string   "created_by"
    t.date     "macrocycle_start_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "macrocycles_users", id: false, force: :cascade do |t|
    t.integer "user_id",       null: false
    t.integer "macrocycle_id", null: false
  end

  add_index "macrocycles_users", ["macrocycle_id", "user_id"], name: "index_Macrocycles_Users_on_macrocycle_id_and_user_id", using: :btree
  add_index "macrocycles_users", ["user_id", "macrocycle_id"], name: "index_Macrocycles_Users_on_user_id_and_macrocycle_id", using: :btree

  create_table "mesocycles", force: :cascade do |t|
    t.integer  "macrocycle_id"
    t.date     "mesocycle_start_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "microcycles", force: :cascade do |t|
    t.integer  "mesocycle_id"
    t.date     "microcycle_start_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "movements", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "positions", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "repranges", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tempos", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tensions", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "bodyweight"
    t.float    "squatmax"
    t.float    "benchmax"
    t.float    "deadliftmax"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_weaknesses", id: false, force: :cascade do |t|
    t.integer "user_id",     null: false
    t.integer "weakness_id", null: false
  end

  add_index "users_weaknesses", ["user_id", "weakness_id"], name: "index_users_weaknesses_on_user_id_and_weakness_id", using: :btree
  add_index "users_weaknesses", ["weakness_id", "user_id"], name: "index_users_weaknesses_on_weakness_id_and_user_id", using: :btree

  create_table "weaknesses", force: :cascade do |t|
    t.string   "name"
    t.string   "bodypart"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "workouts", force: :cascade do |t|
    t.integer  "microcycle_id"
    t.string   "workout_type"
    t.date     "workout_start_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
