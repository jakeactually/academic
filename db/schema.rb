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

ActiveRecord::Schema[8.1].define(version: 2026_04_16_194400) do
  create_table "career_subjects", force: :cascade do |t|
    t.integer "career_id", null: false
    t.datetime "created_at", null: false
    t.integer "semester", null: false
    t.integer "subject_id", null: false
    t.datetime "updated_at", null: false
    t.index ["career_id", "subject_id"], name: "index_career_subjects_on_career_id_and_subject_id", unique: true
    t.index ["career_id"], name: "index_career_subjects_on_career_id"
    t.index ["subject_id"], name: "index_career_subjects_on_subject_id"
  end

  create_table "careers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_careers_on_name", unique: true
  end

  create_table "classrooms", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_classrooms_on_name", unique: true
  end

  create_table "course_classes", force: :cascade do |t|
    t.integer "classroom_id", null: false
    t.datetime "created_at", null: false
    t.integer "dayhour", default: 1, null: false
    t.integer "teacher_subject_id", null: false
    t.datetime "updated_at", null: false
    t.integer "weekday", default: 1, null: false
    t.index ["classroom_id"], name: "index_course_classes_on_classroom_id"
    t.index ["teacher_subject_id", "weekday", "dayhour"], name: "idx_unique_teacher_subject_schedule", unique: true
    t.index ["teacher_subject_id"], name: "index_course_classes_on_teacher_subject_id"
  end

  create_table "dependent_subjects", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "dependent_subject_id", null: false
    t.integer "subject_id", null: false
    t.datetime "updated_at", null: false
    t.index ["dependent_subject_id"], name: "index_dependent_subjects_on_dependent_subject_id"
    t.index ["subject_id", "dependent_subject_id"], name: "idx_unique_subject_dependencies", unique: true
    t.index ["subject_id"], name: "index_dependent_subjects_on_subject_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_subjects_on_name", unique: true
  end

  create_table "teacher_subjects", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "subject_id", null: false
    t.integer "teacher_id", null: false
    t.datetime "updated_at", null: false
    t.index ["subject_id"], name: "index_teacher_subjects_on_subject_id"
    t.index ["teacher_id", "subject_id"], name: "index_teacher_subjects_on_teacher_id_and_subject_id", unique: true
    t.index ["teacher_id"], name: "index_teacher_subjects_on_teacher_id"
  end

  create_table "teachers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_teachers_on_email", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.integer "role", default: 0, null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "career_subjects", "careers"
  add_foreign_key "career_subjects", "subjects"
  add_foreign_key "course_classes", "classrooms"
  add_foreign_key "course_classes", "teacher_subjects"
  add_foreign_key "dependent_subjects", "subjects"
  add_foreign_key "dependent_subjects", "subjects", column: "dependent_subject_id"
  add_foreign_key "teacher_subjects", "subjects"
  add_foreign_key "teacher_subjects", "teachers"
end
