class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def last_name_first
    "#{self.last_name}, #{self.first_name}"
  end

end
