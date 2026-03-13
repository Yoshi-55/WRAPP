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

ActiveRecord::Schema[7.1].define(version: 2026_02_23_171432) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "job_histories", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.string "action_type", null: false
    t.text "note"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["action_type"], name: "index_job_histories_on_action_type"
    t.index ["created_at"], name: "index_job_histories_on_created_at"
    t.index ["deleted_at"], name: "index_job_histories_on_deleted_at"
    t.index ["job_id"], name: "index_job_histories_on_job_id"
  end

  create_table "job_photos", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.string "image_url"
    t.string "photo_type", default: "during", null: false
    t.text "note"
    t.integer "sort_order", default: 0
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_job_photos_on_deleted_at"
    t.index ["job_id"], name: "index_job_photos_on_job_id"
    t.index ["photo_type"], name: "index_job_photos_on_photo_type"
    t.index ["sort_order"], name: "index_job_photos_on_sort_order"
  end

  create_table "jobs", force: :cascade do |t|
    t.bigint "maker_id", null: false
    t.bigint "owner_id", null: false
    t.string "vehicle_name"
    t.string "vehicle_model"
    t.string "vehicle_number"
    t.string "job_serial"
    t.text "description"
    t.string "status", default: "draft", null: false
    t.datetime "started_at"
    t.datetime "completed_at"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "car_year"
    t.string "car_color"
    t.string "customer_name"
    t.string "customer_phone"
    t.datetime "scheduled_at"
    t.text "note"
    t.index ["completed_at"], name: "index_jobs_on_completed_at"
    t.index ["deleted_at"], name: "index_jobs_on_deleted_at"
    t.index ["job_serial"], name: "index_jobs_on_job_serial", unique: true
    t.index ["maker_id"], name: "index_jobs_on_maker_id"
    t.index ["owner_id"], name: "index_jobs_on_owner_id"
    t.index ["started_at"], name: "index_jobs_on_started_at"
    t.index ["status"], name: "index_jobs_on_status"
  end

  create_table "makers", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_makers_on_deleted_at"
    t.index ["name"], name: "index_makers_on_name"
  end

  create_table "material_usages", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.bigint "material_id", null: false
    t.decimal "used_length_m", precision: 10, scale: 2, default: "0.0"
    t.decimal "waste_length_m", precision: 10, scale: 2, default: "0.0"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_material_usages_on_deleted_at"
    t.index ["job_id"], name: "index_material_usages_on_job_id"
    t.index ["material_id"], name: "index_material_usages_on_material_id"
  end

  create_table "materials", force: :cascade do |t|
    t.string "name", null: false
    t.string "brand"
    t.string "color"
    t.integer "width_mm"
    t.decimal "unit_price", precision: 10, scale: 2
    t.string "unit", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand"], name: "index_materials_on_brand"
    t.index ["deleted_at"], name: "index_materials_on_deleted_at"
    t.index ["name"], name: "index_materials_on_name"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "role", default: "owner", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "work_logs", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.bigint "user_id", null: false
    t.datetime "started_at", null: false
    t.datetime "ended_at"
    t.integer "duration_minutes"
    t.text "note"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_work_logs_on_deleted_at"
    t.index ["ended_at"], name: "index_work_logs_on_ended_at"
    t.index ["job_id"], name: "index_work_logs_on_job_id"
    t.index ["started_at"], name: "index_work_logs_on_started_at"
    t.index ["user_id"], name: "index_work_logs_on_user_id"
  end

  add_foreign_key "job_histories", "jobs"
  add_foreign_key "job_photos", "jobs"
  add_foreign_key "jobs", "makers"
  add_foreign_key "jobs", "users", column: "owner_id"
  add_foreign_key "material_usages", "jobs"
  add_foreign_key "material_usages", "materials"
  add_foreign_key "work_logs", "jobs"
  add_foreign_key "work_logs", "users"
end
