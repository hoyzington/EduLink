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

ActiveRecord::Schema.define(version: 2020_07_24_194935) do

  create_table "homeworks", force: :cascade do |t|
    t.string "read", default: "None"
    t.string "exercises", default: "None"
    t.text "other", default: "None"
    t.text "notes", default: "None"
    t.date "date"
    t.boolean "done", default: false
    t.integer "klass_id", null: false
    t.integer "student_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["klass_id"], name: "index_homeworks_on_klass_id"
    t.index ["student_id"], name: "index_homeworks_on_student_id"
  end

  create_table "klasses", force: :cascade do |t|
    t.string "name"
    t.string "period"
    t.integer "teacher_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "dept"
    t.index ["teacher_id"], name: "index_klasses_on_teacher_id"
  end

  create_table "quiz_grades", force: :cascade do |t|
    t.integer "number"
    t.integer "grade"
    t.integer "student_status_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["student_status_id"], name: "index_quiz_grades_on_student_status_id"
  end

  create_table "student_statuses", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.integer "id_number"
    t.boolean "tutored?", default: false
    t.integer "klass_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "student_id", default: 0
    t.index ["klass_id"], name: "index_student_statuses_on_klass_id"
    t.index ["student_id"], name: "index_student_statuses_on_student_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.integer "id_number"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "teachers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.integer "id_number"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "dept"
  end

  add_foreign_key "homeworks", "klasses"
  add_foreign_key "homeworks", "students"
  add_foreign_key "klasses", "teachers"
  add_foreign_key "quiz_grades", "student_statuses"
  add_foreign_key "student_statuses", "klasses"
  add_foreign_key "student_statuses", "students"
end
