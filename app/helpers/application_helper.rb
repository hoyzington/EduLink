module ApplicationHelper

  def day_format
    "%A, %m/%d/%y "
  end

  def homework_when
    Time.now.on_weekend? ? "This Weekend" : "Today (#{Time.now.strftime("%A")})"
  end

# Klass Links

  def klass_heading_and_link(klass)
    link_to "#{klass.name}, Period #{klass.period}", teacher_klass_path(current_user, klass)
  end

  def new_klass_link
    link_to "Add A Class", teacher_klasses_new_path(current_user), class: ""
  end

# StudentStatus Links

  def link_to_add_student_status(klass)
    link_to 'Add Student', klass_student_statuses_new_path(klass)
  end

# Homework Links

  def link_to_add_homework(klass)
    link_to "Add New Homework", klass_homeworks_new_path(klass)
  end

  def link_to_future_homework(klass)
    link_to "Future Homework", klass_future_homeworks_path(klass)
  end

  def link_to_past_homework(klass)
    link_to "Past Homework", klass_past_homeworks_path(klass)
  end

end
