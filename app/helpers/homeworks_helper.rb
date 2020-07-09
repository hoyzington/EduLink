module HomeworksHelper

  def days_later(num)
    60*60*24 * num
  end

  def homework_assigned?(week_day)
    !!@klass.homeworks.detect{|h| h.date == week_day}
  end

end
