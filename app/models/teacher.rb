class Teacher < ApplicationRecord

  has_many :klasses
  has_many :student_statuses, through: :klasses
  has_many :homeworks, through: :klasses

  validates :id_number, presence: true, uniqueness: true
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :dept
  validates :email, presence: true, uniqueness: {case_sensitive: false}, length: {maximum: 100}, format: {with: VALID_EMAIL}

  has_secure_password

  before_save {self.email = self.email.downcase}
  before_save {self.dept = self.dept.titlecase}

  def admin?
    self.is_default
  end

end
