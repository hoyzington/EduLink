class ApplicationController < ActionController::Base

  helper_method :current_user, :logged_in?, :require_user, :user_is_teacher?, :user_is_admin?, :find_admin_or_first_student, :unauthorized

  FIRST_ID = 1

  def current_user
    if session[:user_id]
      if session[:teacher]
        @current_user ||= Teacher.find(session[:user_id])
      else
        @current_user ||= Student.find(session[:user_id])
      end
    end
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:alert] = "You must log in first."
      redirect_to login_path
    end
  end

  def user_is_teacher?
    session[:teacher]
  end

  def user_is_admin?
    user_is_teacher? && session[:user_id] == 1
  end

  def find_admin_or_first_student(array)
    array.detect {|x| x.id_number == FIRST_ID}
  end

  def unauthorized
    flash[:alert] = "Unauthorized Action"
    redirect_to home_path
  end

  def day_format
    "%A, %m/%d/%y "
  end

end
