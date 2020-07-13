module HomeworksHelper

  def weekday_only
    if Time.now.saturday?
      num = 2
    elsif Time.now.sunday?
      num = 1
    else
      num = 0
    end
    Time.now + (add_day * num)
  end

  def add_day
    60*60*24
  end

  def homework_assigned?(day)
    !!@klass.homeworks.detect{|h| h.date == day}
  end

end
