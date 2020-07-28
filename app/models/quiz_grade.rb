class QuizGrade < ApplicationRecord

  belongs_to :student_status

  validates_presence_of :grade

end
