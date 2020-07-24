class Student < ApplicationRecord

  has_many :student_statuses
  has_many :klasses, through: :student_statuses
  has_many :quiz_grades, through: :student_statuses
  has_many :homeworks
  has_many :klasses, through: :homeworks

  has_secure_password

  before_save {self.email = self.email.downcase}

end
