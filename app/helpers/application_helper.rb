module ApplicationHelper

  FIRST_ID = 1

  def day_format
    "%A, %m/%d/%y "
  end

  def homework_when
    Time.now.on_weekend? ? "This Weekend" : "Today (#{Time.now.strftime("%A")})"
  end

# Flexible Links

  def link_to_delete(obj)
    unless (obj.class == Teacher) && (obj.id_number == FIRST_ID)
      if obj.class == Teacher
        title = 'Delete Teacher'
      elsif obj.class == Klass
        title = 'Delete Class'
      elsif obj.class == Homework
        title = 'Delete'
      else
        title = 'Delete Student'
      end
      link_to title, obj, method: :delete, data: { confirm: "Are you sure?" }
    end
  end

  # Admin Links

  def link_to_end_of_year_proceedure(teacher)
    if user_is_admin? && teacher == current_user
      link_to "End Of Year Proceedure", teacher_end_of_year_path(current_user)
    end
  end

  def link_to_students
    link_to 'Students', students_path
  end

# Teacher Links

  def link_to_edit_teacher
    link_to "Edit Profile", edit_teacher_path(current_user)
  end

# Klass Links

  def klass_heading_and_link(klass)
    link_to "#{klass.name}, Period #{klass.period}", teacher_klass_path(current_user, klass)
  end

  def link_to_new_klass
    unless user_is_admin?
      link_to "Add A Class", teacher_klasses_new_path(current_user)
    end
  end

  def link_to_edit_klass
    link_to "Edit Class", teacher_klasses_edit_path(@klass.teacher, @klass)
  end

  def link_to_klasses
    if user_is_teacher?
      link_to "Classes", teacher_klasses_path(current_user)
    else
      link_to "Classes", student_klasses_path(current_user)
    end
  end

# StudentStatus Links

  def link_to_add_student_status(klass)
    unless user_is_admin?
      link_to 'Add Student', klass_student_statuses_new_path(klass)
    end
  end

  def link_to_edit_student_status(klass, student_status)
    unless user_is_admin? 
      link_to "Edit Profile", klass_student_statuses_edit_path(klass, student_status)
    end
  end

# QuizGrade Links

  def link_to_new_quiz_grades(klass)
    unless user_is_admin?
      link_to "Enter Quiz Grades", klass_quiz_grades_new_path(klass)
    end
  end

  def link_to_edit_quiz_grade(klass, quiz_grade)
    unless user_is_admin? 
      link_to 'Edit', klass_quiz_grades_edit_path(klass, quiz_grade)
    end
  end

# Homework Links

  def link_to_add_homework(klass)
    unless user_is_admin?
      link_to "Add New Homework", klass_homeworks_new_path(klass)
    end
  end

  def link_to_edit_homework(klass, homework)
    unless user_is_admin? 
      link_to "Edit", klass_homeworks_edit_path(klass, homework)
    end
  end

  def link_to_future_homework(klass)
    link_to "Future Homework", klass_future_homeworks_path(klass)
  end

  def link_to_past_homework(klass)
    link_to "Past Homework", klass_past_homeworks_path(klass)
  end

end
