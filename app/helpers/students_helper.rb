module StudentsHelper

  def student_status_list
    students = @klass.student_statuses
    students.sort_by {|student| student[:last_name]}
  end

end
