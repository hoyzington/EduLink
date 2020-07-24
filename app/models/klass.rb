class Klass < ApplicationRecord

  belongs_to :teacher
  has_many :student_statuses
  has_many :students, through: :student_statuses
  has_many :quiz_grades, through: :student_statuses
  has_many :homeworks
  has_many :students, through: :homeworks

  before_save {self.name = self.name.titlecase}
  before_save {self.dept = self.dept.titlecase}

  def create_default_student_status
    dss = Student.find_by(id_number: 0)
    self.student_statuses.create(id_number: dss.id_number, first_name: dss.first_name, last_name: dss.last_name, student_id: dss.id)
  end

  def self.by_teacher_by_period(teacher_id)
    where(teacher: teacher_id).sort_by {|klass| klass[:period]}
  end

  def current_homework(id)
    hw = self.homeworks_by_student(id)
    hw.detect {|h| h.assigned_for.today?}
  end

  def new_homework_for_each_student(params)
    students = self.student_statuses
    students.each do |s|
      homework = Homework.new(params)
      homework.student_id = s.student.id
      homework.done = true if s.student.id == 0
      homework.save
    end
  end

  def past_homework_by_student(id)
    hw = self.homeworks_by_student(id)
    homeworks = hw.select {|h| h.date.day < Time.now.day}
    @homeworks = homeworks.sort_by {|h| h.date}.reverse
  end

  def homeworks_by_student(id)
    self.homeworks.select {|h| h.student_id == id}
  end

end
