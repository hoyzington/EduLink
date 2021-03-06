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
    self.order(:last_name, :first_name).select {|ss| !ss.default?}
  end

  def late_homeworks(klass)
    self.student.homeworks.select {|h| (h.klass_id == klass.id) && (h.past?) && (h.done == false)}
  end

  def delete_homework
    student_homeworks = self.student.homeworks
    student_klass_homeworks = student_homeworks.select {|h| h.klass == self.klass}
    student_klass_homeworks.each {|h| h.delete}
  end

  def self.non_edulink_students
    self.order(:last_name, :first_name).select {|ss| ss.default_or_nonlinked? && !ss.default?}
  end

  def default_or_nonlinked?
    self.student_id == 1
  end

end
