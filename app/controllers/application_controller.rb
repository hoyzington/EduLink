class ApplicationController < ActionController::Base

  helper_method :current_user, :logged_in?, :require_user, :user_is_teacher?, :user_is_admin?, :require_teacher, :require_admin, :require_student, :find_admin_or_first_student, :login, :unauthorized, :day_format, :destroy_student_status_etc

  FIRST_ID = 1

  def current_user
    if session[:user_id]
      if session[:teacher]
        @current_user ||= Teacher.find_by(id: session[:user_id])
      else
        @current_user ||= Student.find_by(id: session[:user_id])
      end
      if !@current_user
        session.clear
        redirect_to root_path
      else
        @current_user
      end
    end
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:alert] = "Please log in first."
      redirect_to login_path
    end
  end

  def user_is_teacher?
    session[:teacher] == 'true'
  end

  def user_is_admin?
    user_is_teacher? && session[:user_id] == FIRST_ID
  end

  def require_teacher
    unauthorized unless user_is_teacher?
  end

  def require_admin
    unauthorized unless user_is_admin?
  end

  def require_student
    unauthorized unless current_user.class == Student
  end

  def find_admin_or_first_student(array)
    array.detect {|x| x.is_default}
  end

  def login(user, welcome)
    session[:user_id] = user.id
    session[:teacher] = 'true' if user.class == Teacher
    flash[:notice] = "#{welcome}, #{user.first_name}!"
    redirect_to user
  end

  def unauthorized
    redirect_to home_path, alert: "Unauthorized Action"
  end

  def day_format
    "%A, %m/%d/%y "
  end

# StudentStatusesController & StudentsController

  def destroy_student_status_etc(student_status)
    student_status.delete_homework
    student_status.quiz_grades.clear
    student_status.destroy
  end
end
