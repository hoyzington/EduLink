module HomeworksHelper

  FIRST_ID = 1

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

  def homework_assigned?(assign_date)
    !!@klass.homeworks.detect{|h| h.date.strftime(day_format) == assign_date.strftime(day_format)}
  end

  def fetch_homework(klass, assign_date)
    homeworks = klass.homeworks.select {|h| h.student_id == FIRST_ID}
    homeworks.detect {|h| h.date.strftime("%y%m%d") == assign_date.strftime("%y%m%d")}
  end

  def next_day(date)
    date.friday? ? date += (add_day * 3) : date += add_day
  end

end
