class Klass < ApplicationRecord

  belongs_to :teacher
  has_many :student_statuses, dependent: :destroy
  has_many :students, through: :student_statuses
  has_many :quiz_grades, through: :student_statuses
  has_many :homeworks, dependent: :destroy
  has_many :students, through: :homeworks

  validates_presence_of :name
  validates_presence_of :dept
  validates :period, presence: true, numericality: { only_integer: true, greater_than: 0, less_than: 8 }

  before_save {self.name = self.name.titlecase}
  before_save {self.dept = self.dept.titlecase}

  def create_default_student_status
    ds = Student.find_by(id_number: 0)
    self.student_statuses.create(id_number: ds.id_number, first_name: ds.first_name, last_name: ds.last_name, student_id: ds.id)
  end

  def self.by_teacher_by_period(teacher_id)
    where(teacher: teacher_id).sort_by {|klass| klass[:period]}
  end

  def current_homework(id)
    hw = self.homeworks_by_student(id)
    hw.detect {|h| h.assigned_for.today?}
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
