class Klass < ApplicationRecord

  belongs_to :teacher
  has_many :student_statuses
  has_many :students, through: :student_statuses
  has_many :homeworks
  has_many :students, through: :homeworks

  before_save {self.name = self.name.titlecase}
  before_save {self.dept = self.dept.titlecase}

  def self.by_teacher_by_period(teacher_id)
    where(teacher: teacher_id).sort_by {|klass| klass[:period]}
  end

  def current_homework
    self.homeworks.detect {|h| h.assigned_for.today?}
  end

end
