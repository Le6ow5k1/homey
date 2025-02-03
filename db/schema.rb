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

ActiveRecord::Schema[7.1].define(version: 2024_02_14_000005) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "activity_subject_type", ["Comment", "StatusChange"]
  create_enum "project_status", ["open", "in_progress", "completed", "on_hold"]

  create_table "comments", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "user_id", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id", "created_at"], name: "index_comments_on_project_id_and_created_at"
    t.index ["project_id"], name: "index_comments_on_project_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "project_activities", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "user_id", null: false
    t.enum "subject_type", null: false, enum_type: "activity_subject_type"
    t.bigint "subject_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id", "created_at"], name: "index_project_activities_on_project_id_and_created_at"
    t.index ["project_id"], name: "index_project_activities_on_project_id"
    t.index ["subject_type", "subject_id"], name: "index_project_activities_on_subject_type_and_subject_id"
    t.index ["user_id"], name: "index_project_activities_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.enum "status", default: "open", null: false, enum_type: "project_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "status_changes", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "user_id", null: false
    t.enum "previous_status", null: false, enum_type: "project_status"
    t.enum "new_status", null: false, enum_type: "project_status"
    t.text "change_reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id", "created_at"], name: "index_status_changes_on_project_id_and_created_at"
    t.index ["project_id"], name: "index_status_changes_on_project_id"
    t.index ["user_id"], name: "index_status_changes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email"
  end

  add_foreign_key "comments", "projects"
  add_foreign_key "comments", "users"
  add_foreign_key "project_activities", "projects"
  add_foreign_key "project_activities", "users"
  add_foreign_key "status_changes", "projects"
  add_foreign_key "status_changes", "users"
end
