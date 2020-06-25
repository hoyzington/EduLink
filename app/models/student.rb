class Student < ApplicationRecord

  has_many :student_statuses
  has_many :klasses, through: :student_statuses
  has_many :homeworks
  has_many :klasses, through: :homeworks

end
