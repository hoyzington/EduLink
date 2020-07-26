class ApplicationController < ActionController::Base

  helper_method :current_user, :logged_in?, :require_user, :admin_or_same_user, :user_is_teacher?, :user_is_admin?, :restore_admin, :check_default_student, :find_admin_or_default

  DEFAULT_ID = 0

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

  def admin_or_same_user
    if current_user != @user && !current_user.admin?
      flash[:alert] = 'Unauthorized Action'
      redirect_to user_path(current_user)
    end
  end

  def user_is_teacher?
    session[:teacher]
  end

  def user_is_admin?
    user_is_teacher? && session[:user_id] == 1
  end

  def restore_admin
    if Teacher.first.id != 1
      Teacher.create(first_name: "William", last_name: "McKinley", id_number: 0, email: "william@email.com", password: "password", id: 1)
    end
  end

  def check_default_student
    if !Student.find_by(id_number: 0)
      Student.create(id: 0, first_name: "Default", last_name: "Student", id_number: 0, email: "default@email.com", password: "password")
    end
  end

  def find_admin_or_default(array)
    array.detect {|s| s.id_number == DEFAULT_ID}
  end

end
