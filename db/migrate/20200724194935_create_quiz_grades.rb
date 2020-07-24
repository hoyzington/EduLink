class CreateQuizGrades < ActiveRecord::Migration[6.0]
  def change
    create_table :quiz_grades do |t|
      t.integer :number
      t.integer :grade
      t.belongs_to :student_status, null: false, foreign_key: true

      t.timestamps
    end
  end
end
