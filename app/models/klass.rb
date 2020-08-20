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

  def self.filtered_by_teacher(teacher_id)
    where(teacher: teacher_id).sort_by {|klass| klass[:period]}
  end

  def past_homework_by_student(id)
    hw = self.homeworks.by_student(id)
    homeworks = hw.select {|h| h.past?}
    @homeworks = homeworks.sort_by {|h| h.date}.reverse
  end

  def delete_homework(homework)
    homeworks = self.homeworks.select {|h| h.date == homework.date}
    homeworks.clear
  end

end
