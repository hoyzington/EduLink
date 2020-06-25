class CreateStudentStatuses < ActiveRecord::Migration[6.0]
  def change
    create_table :student_statuses do |t|
      t.string :first_name
      t.string :last_name
      t.integer :id_number
      t.integer :exams, array: true
      t.integer :quizes, array: true
      t.integer :projects, array: true
      t.boolean :tutored?, default: false
      t.belongs_to :klass, null: false, foreign_key: true
      t.belongs_to :student, null: true, foreign_key: true

      t.timestamps
    end
  end
end
