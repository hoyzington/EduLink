class Teacher < ApplicationRecord

  has_many :klasses
  has_many :student_statuses, through: :klasses
  has_many :homeworks, through: :klasses

end
