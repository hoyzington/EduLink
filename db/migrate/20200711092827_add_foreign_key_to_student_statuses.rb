class AddForeignKeyToStudentStatuses < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key "student_statuses", "students"
  end
end
