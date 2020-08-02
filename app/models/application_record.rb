class ApplicationRecord < ActiveRecord::Base

  self.abstract_class = true

  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  FIRST_ID = 0

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def last_name_first
    "#{self.last_name}, #{self.first_name}"
  end

end
