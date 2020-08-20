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

  def homework_assigned?
    !!@klass.homeworks.detect{|h| h.formatted_date == @date.strftime(day_format)}
  end

  def homework_for(date)
    homeworks = @klass.homeworks.select {|h| h.student_id == FIRST_ID}
    homeworks.detect {|h| h.date.strftime("%y%m%d") == date.strftime("%y%m%d")}
  end

  def next_day
    @date.friday? ? @date += (add_day * 3) : @date += add_day
  end

  def clickable_homework_to_edit
    title = "✔ #{@date.strftime(day_format)}"
    link_to title, klass_homeworks_edit_path(@klass, homework_for(@date))
  end

end
