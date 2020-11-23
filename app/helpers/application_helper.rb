module ApplicationHelper

  FIRST_ID = 1

# Homework Display Helper

  def homework_when
    Time.now.on_weekend? ? "This Weekend" : "Today (#{Time.now.strftime("%A")})"
  end

# Session Link

  def link_to_home
    link_to 'Back', home_path
  end

# Flexible Links

  def link_to_edulink
    link_to "#{current_user.first_name}'s EduLink", home_path
  end

  def link_to_logout
    link_to "Log Out", logout_path, method: :delete
  end

  def link_to_delete(obj)
    unless (obj.class == Teacher) && (obj.default?)
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

  def link_to_edit_profile(user)
    model = "#{user.class}".downcase
    link_to 'Edit Profile', "/#{model}s/#{user.id}/edit"
  end

# Admin Links

  def link_to_end_of_year_proceedure
    link_to "End Of Year Proceedure", teacher_end_of_year_path(current_user)
  end

  def link_to_add_teacher
    link_to 'Add New Teacher', new_teacher_path
  end

  def link_to_students
    link_to 'Students', students_path
  end

# Teacher Links

# Klass Links

  def klass_heading_and_link
    link_to "#{@klass.name}, Period #{@klass.period}", teacher_klass_path(current_user, @klass)
  end

  def link_to_add_klass
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

  def link_to_add_student_status
    unless user_is_admin?
      link_to 'Add Students', klass_student_statuses_new_path(@klass)
    end
  end

  def link_to_edit_student_status
    unless user_is_admin? 
      link_to "Edit Profile", klass_student_statuses_edit_path(@klass, @student_status)
    end
  end

  def link_to_klass_student_statuses
    link_to "Students", klass_student_statuses_path(@klass) if @student_statuses.count > 1
  end

# QuizGrade Links

  def link_to_add_quiz_grades
    unless user_is_admin?
      link_to "Enter Quiz Grades", klass_quiz_grades_new_path(@klass)
    end
  end

  def link_to_edit_quiz_grade
    unless user_is_admin? 
      link_to 'Edit', klass_quiz_grades_edit_path(@klass, @quiz_grade)
    end
  end

# Homework Links

  def link_to_add_homework
    unless user_is_admin?
      link_to "Add New Homework", klass_homeworks_new_path(@klass)
    end
  end

  def link_to_edit_homework
    unless user_is_admin? 
      link_to "Edit", klass_homeworks_edit_path(@klass, @homework)
    end
  end

  def link_to_future_homework
    link_to "Future Homework", klass_future_homeworks_path(@klass)
  end

  def link_to_past_homework
    link_to "Past Homework", klass_past_homeworks_path(@klass)
  end

end
