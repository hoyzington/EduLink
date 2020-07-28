class Student < ApplicationRecord

  has_many :student_statuses
  has_many :klasses, through: :student_statuses
  has_many :quiz_grades, through: :student_statuses
  has_many :homeworks
  has_many :klasses, through: :homeworks

  validates :id_number, presence: true, uniqueness: true
  valdates_presence_of :first_name
  valdates_presence_of :last_name
  validates :email, presence: true, uniqueness: {case_sensitive: false}, length: {maximum: 100}, format: {with: VALID_EMAIL}

  has_secure_password

  before_save {self.email = self.email.downcase}

end
