class ApplicationController < ActionController::Base

  helper_method :current_user, :user_is_teacher?, :user_is_admin?, :logged_in?, :require_user, :require_teacher, :require_admin, :login, :unauthorized, :destroy_student_status_etc

  FIRST_ID = 1

# Uses:  Many controllers and views

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

  def user_is_teacher?
    session[:teacher] == 'true'
  end

  def user_is_admin?
    user_is_teacher? && session[:user_id] == FIRST_ID
  end

# Uses:  Here, PagesController, Navbar partial

  def logged_in?
    !!current_user
  end

# Uses:  Controllers:  StudentStatuses, Homeworks, Students

  def require_user
    if !logged_in?
      flash[:alert] = "Please log in first."
      redirect_to login_path
    end
  end

# Uses:  Controllers:  All except Students

  def require_teacher
    unauthorized unless user_is_teacher?
  end

# Uses:  Controllers:  Teachers, Klasses, Students

  def require_admin
    unauthorized unless user_is_admin?
  end

# Uses:  Controllers:  Sessions, Students

  def login(user, welcome)
    session[:user_id] = user.id
    session[:teacher] = 'true' if user.class == Teacher
    flash[:notice] = "#{welcome}, #{user.first_name}!"
    redirect_to user
  end

# Uses:  Controllers:  Teachers, Homeworks, QuizGrades

  def unauthorized
    redirect_to home_path, alert: "Unauthorized Action"
  end

# Uses:  Controllers:  StudentStatuses, Students

  def destroy_student_status_etc(student_status)
    student_status.delete_homework
    student_status.quiz_grades.clear
    student_status.destroy
  end
  
end
