class Homework < ApplicationRecord

  belongs_to :klass
  belongs_to :student

  validates_presence_of :date

  def assigned_for
    today = Time.now
    if today.saturday?
      day = (self.date + 1)
    elsif today.sunday?
      day = (self.date + 2)
    else
      day = self.date
    end
    day
  end

end
