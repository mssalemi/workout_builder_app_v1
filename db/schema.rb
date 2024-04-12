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

ActiveRecord::Schema[7.1].define(version: 2024_04_12_233837) do
  create_table "exercise_histories", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "exercise_id", null: false
    t.integer "workout_id", null: false
    t.date "date"
    t.json "performance_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "completed", default: false, null: false
    t.integer "order", default: 0
    t.index ["exercise_id"], name: "index_exercise_histories_on_exercise_id"
    t.index ["user_id"], name: "index_exercise_histories_on_user_id"
    t.index ["workout_id"], name: "index_exercise_histories_on_workout_id"
  end

  create_table "exercises", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.string "category", default: "Chest", null: false
    t.json "body_part_accessory"
    t.string "body_part_main", null: false
  end

  create_table "friendships", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "friend_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["friend_id"], name: "index_friendships_on_friend_id"
    t.index ["user_id", "friend_id"], name: "index_friendships_on_user_id_and_friend_id", unique: true
    t.index ["user_id"], name: "index_friendships_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

  create_table "weeks", force: :cascade do |t|
    t.integer "workout_program_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order"
    t.index ["workout_program_id"], name: "index_weeks_on_workout_program_id"
  end

  create_table "workout_programs", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.integer "user_id", null: false
    t.string "difficulty_level"
    t.integer "duration_weeks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_workout_programs_on_user_id"
  end

  create_table "workouts", force: :cascade do |t|
    t.string "title"
    t.json "goal"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "workout_week_id"
    t.integer "order"
    t.index ["user_id"], name: "index_workouts_on_user_id"
    t.index ["workout_week_id"], name: "index_workouts_on_workout_week_id"
  end

  add_foreign_key "exercise_histories", "exercises"
  add_foreign_key "exercise_histories", "users"
  add_foreign_key "exercise_histories", "workouts"
  add_foreign_key "weeks", "workout_programs"
  add_foreign_key "workout_programs", "users"
  add_foreign_key "workouts", "users"
end
