class StudentStatus < ApplicationRecord

  has_many :quiz_grades, dependent: :destroy
  belongs_to :klass
  belongs_to :student

  validates_presence_of :id_number
  validates_presence_of :first_name
  validates_presence_of :last_name

  def late_homework(klass_id)
    self.student.homeworks.select {|h| h.klass_id == klass_id && h.done == false}
  end

  def delete_homework
    student_homework = self.student.homeworks
    student_klass_homework = student_homework.select {|h| h.klass == self.klass}
    student_klass_homework.each {|h| h.delete}
  end

  def delete_quiz_grades
    self.quiz_grades.each {|q| q.delete}
  end

end
