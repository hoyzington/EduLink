class RemoveStudentIdFromStudentStatuses < ActiveRecord::Migration[6.0]
  def change
    remove_column :student_statuses, :student_id, :integer
  end
end
