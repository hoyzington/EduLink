class ChangeColumnsInStudentStatuses < ActiveRecord::Migration[6.0]
  def change
    change_table :student_statuses do |t|
      t.remove :exams, :quizes, :projects
    end
  end
end
