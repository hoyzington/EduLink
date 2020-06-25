class Klass < ApplicationRecord

  belongs_to :teacher
  has_many :student_statuses
  has_many :students, through: :student_statuses
  has_many :homeworks
  has_many :students, through: :homeworks

end
