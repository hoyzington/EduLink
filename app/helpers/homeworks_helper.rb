module HomeworksHelper

  FIRST_ID = 1

# Helper methods for displaying/formatting homework radio button text

  def day_format
    "%A, %m/%d/%y "
  end

  def add_day
    60*60*24
  end

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

  def homework_assigned?
    !!@klass.homeworks.detect{|h| h.formatted_date == @date.strftime(day_format)}
  end

  def clickable_homework_to_edit
    title = "✔ #{@date.strftime(day_format)}"
    link_to title, klass_homeworks_edit_path(@klass, homework_for(@date))
  end

  def next_day
    @date.friday? ? @date += (add_day * 3) : @date += add_day
  end

end
