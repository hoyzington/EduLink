class StudentStatus < ApplicationRecord

  has_many :quiz_grades, dependent: :destroy
  belongs_to :klass
  belongs_to :student

  validates_presence_of :id_number
  validates_presence_of :first_name
  validates_presence_of :last_name

  def link_with_student
    student = Student.find_by(id_number: self.id_number)
    self.student = student || Student.find(FIRST_ID)
  end

  def self.list
    self.order(:last_name, :first_name).select {|ss| ss.id_number > FIRST_ID}
  end

  def late_homework(klass_id)
    self.student.homeworks.select {|h| h.klass_id == klass_id && h.not_done}
  end

  def delete_homework
    student_homework = self.student.homeworks
    student_klass_homework = student_homework.select {|h| h.klass == self.klass}
    student_klass_homework.each {|h| h.delete}
  end

  def self.not_on_edulink
    self.order(:last_name, :first_name).select {|ss| ss.student_id == FIRST_ID && ss.id_number > FIRST_ID}
  end

end
