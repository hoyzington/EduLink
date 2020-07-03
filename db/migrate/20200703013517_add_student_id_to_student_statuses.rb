class AddStudentIdToStudentStatuses < ActiveRecord::Migration[6.0]
  def change
    remove_column :student_statuses, :student_id
    change_table :student_statuses do |t|
      t.integer "student_id", default: 0
      t.index ["student_id"], name: "index_student_statuses_on_student_id"
    end
  end
end
