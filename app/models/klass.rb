class Klass < ApplicationRecord

  belongs_to :teacher
  has_many :student_statuses
  has_many :students, through: :student_statuses
  has_many :homeworks
  has_many :students, through: :homeworks

  def self.by_teacher_by_period(teacher_id)
    where(teacher: teacher_id).sort_by {|klass| klass[:period]}
  end

end
