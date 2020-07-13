class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def last_name_first
    "#{self.last_name}, #{self.first_name}"
  end

  # def today
  #   Time.now.strftime("%A, %m/%d/%y")
  # end

end
