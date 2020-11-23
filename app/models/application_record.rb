class ApplicationRecord < ActiveRecord::Base

  self.abstract_class = true

  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  FIRST_ID = 1

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def last_name_first
    "#{self.last_name}, #{self.first_name}"
  end

  # def default?
  #   if self.class == StudentStatus
  #     self.id_number == FIRST_ID
  #   else
  #     self.id_number == FIRST_ID || self.student_id == FIRST_ID || self.id == FIRST_ID
  #   end
  # end

  def default?
    if self.class == Homework
      self.student_id == FIRST_ID
    else
      self.id_number == FIRST_ID
    end
  end

end
