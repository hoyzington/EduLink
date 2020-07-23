class StudentStatus < ApplicationRecord

  belongs_to :klass
  belongs_to :student

  def late_homework(klass_id)
    self.student.homeworks.select {|h| h.klass_id == klass_id && h.done == false}
  end

end
