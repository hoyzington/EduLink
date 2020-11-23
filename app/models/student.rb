class Student < ApplicationRecord

  has_many :student_statuses
  has_many :klasses, through: :student_statuses
  has_many :quiz_grades, through: :student_statuses
  has_many :homeworks
  has_many :klasses, through: :homeworks

  validates :id_number, presence: true, uniqueness: true
  validates_presence_of :first_name
  validates :email, presence: true, uniqueness: {case_sensitive: false}, length: {maximum: 100}, format: {with: VALID_EMAIL}

  has_secure_password

  before_save {self.email = self.email.downcase}

  def self.visible
    where('id > ?', '1')
  end

  def self.list
    order(:last_name, :first_name)
  end

  def self.search(query)
    where('first_name LIKE ? OR last_name LIKE ?', "%#{query}%", "%#{query}%")
  end

end
