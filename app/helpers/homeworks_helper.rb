module HomeworksHelper

  def future_weekday_only
    if Time.now.friday?
      num = 3
    elsif Time.now.saturday?
      num = 2
    else
      num = 1
    end
    Time.now + (add_day * num)
  end

  def add_day
    60*60*24
  end

  def homework_assigned?(day)
    !!@klass.homeworks.detect{|h| h.date.day == day.day}
  end

end
