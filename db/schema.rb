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

ActiveRecord::Schema[7.2].define(version: 2024_11_19_022133) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "body_part_exercises", force: :cascade do |t|
    t.bigint "body_part_id", null: false
    t.bigint "exercise_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["body_part_id"], name: "index_body_part_exercises_on_body_part_id"
    t.index ["exercise_id"], name: "index_body_part_exercises_on_exercise_id"
  end

  create_table "body_parts", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "equipament_exercises", id: false, force: :cascade do |t|
    t.bigint "equipament_id", null: false
    t.bigint "exercise_id", null: false
    t.index ["equipament_id"], name: "index_equipament_exercises_on_equipament_id"
    t.index ["exercise_id"], name: "index_equipament_exercises_on_exercise_id"
  end

  create_table "equipaments", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exercises", force: :cascade do |t|
    t.string "name"
    t.string "instructions"
    t.string "exercise_type"
    t.boolean "is_favorite", default: false
    t.integer "num_exercises"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "video_name"
    t.string "image_name"
    t.string "video_url"
    t.index ["user_id"], name: "index_exercises_on_user_id"
  end

  create_table "synergist_muscles", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "synergist_muscles_exercises", force: :cascade do |t|
    t.bigint "synergist_muscle_id", null: false
    t.bigint "exercise_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_synergist_muscles_exercises_on_exercise_id"
    t.index ["synergist_muscle_id"], name: "index_synergist_muscles_exercises_on_synergist_muscle_id"
  end

  create_table "target_muscles", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "target_muscles_exercises", force: :cascade do |t|
    t.bigint "target_muscle_id", null: false
    t.bigint "exercise_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_target_muscles_exercises_on_exercise_id"
    t.index ["target_muscle_id"], name: "index_target_muscles_exercises_on_target_muscle_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.string "password_confirmation"
    t.string "role", default: "client"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "workouts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_workouts_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "body_part_exercises", "body_parts"
  add_foreign_key "body_part_exercises", "exercises"
  add_foreign_key "equipament_exercises", "equipaments"
  add_foreign_key "equipament_exercises", "exercises"
  add_foreign_key "exercises", "users"
  add_foreign_key "synergist_muscles_exercises", "exercises"
  add_foreign_key "synergist_muscles_exercises", "synergist_muscles"
  add_foreign_key "target_muscles_exercises", "exercises"
  add_foreign_key "target_muscles_exercises", "target_muscles"
  add_foreign_key "workouts", "users"
end
