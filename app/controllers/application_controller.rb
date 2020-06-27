class ApplicationController < ActionController::Base

  helper_method :current_user, :logged_in?, :require_user, :admin_or_same_user, :user_is_teacher?, :user_is_admin?, :restore_admin

  def current_user
    @current_user ||= Teacher.find(session[:user_id]) if session[:user_id]
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

end
