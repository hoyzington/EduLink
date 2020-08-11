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

  def create_first_student_status
    s = Student.find_by(id_number: FIRST_ID)
    self.student_statuses.create(id_number: s.id_number, first_name: s.first_name, last_name: s.last_name, student_id: s.id)
  end

  def self.filtered_by_teacher(teacher_id)
    where(teacher: teacher_id).sort_by {|klass| klass[:period]}
  end

  def non_edulink_students
    self.student_statuses.select {|ss| ss.student_id == FIRST_ID && ss.id_number > FIRST_ID}
  end

  def homeworks_by_student(id)
    self.homeworks.select {|h| h.student_id == id}
  end

  def current_homework(id)
    hw = self.homeworks_by_student(id)
    hw.detect {|h| h.assigned_for.today?}
  end

  def past_homework_by_student(id)
    hw = self.homeworks_by_student(id)
    homeworks = hw.select {|h| h.past?}
    @homeworks = homeworks.sort_by {|h| h.date}.reverse
  end

  def delete_homework(homework)
    homeworks = self.homeworks.select {|h| h.date == homework.date}
    homeworks.each {|h| h.delete}
  end

end
