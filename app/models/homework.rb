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

  def past?
    self.date.strftime("%y%m%d") < Time.now.strftime("%y%m%d")
  end

  def future?
    self.date.strftime("%y%m%d") > Time.now.strftime("%y%m%d")
  end

  def not_done
    self.past? && self.done == false
  end

  def self.current(id)
    self.by_student(id).detect {|h| h.assigned_for.today?}
  end

  def self.by_student(id)
    self.select {|h| h.student_id == id}
  end

  def self.not_done
    self.select {|h| h.past? && h.done == false}
  end

end
