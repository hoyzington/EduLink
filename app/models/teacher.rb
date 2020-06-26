class Teacher < ApplicationRecord

  has_many :klasses
  has_many :student_statuses, through: :klasses
  has_many :homeworks, through: :klasses

  has_secure_password

  def admin?
    self.id == 1
  end

end
