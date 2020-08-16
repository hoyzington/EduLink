class SessionsController < ApplicationController

  def new
  end

  def create
    @user = find_teacher_or_student
    if @user && @user.authenticate(params[:session][:password])
      session[:teacher] = 'true' if @user.class == Teacher
      login(@user, 'Welcome back')
    else
      flash[:alert] = "There was something wrong with your login details."
      redirect_to login_path
    end
  end

  def omniauth
    @student = Student.find_by(email: auth[:info][:email])
    if @student
      login(@student, 'Welcome back')
    else
      info = auth[:info]
      fb_name = info[:name].split
      @student = Student.new(email: info[:email], first_name: fb_name.first, last_name: (fb_name.last if fb_name.count > 1))
      session[:oauth] = 'true'
      render 'students/finish_profile'
    end
  end

  def destroy
    session.clear
    redirect_to root_path, notice: "Come back soon!"
  end

  private

  def auth
    request.env['omniauth.auth']
  end

  def find_teacher_or_student
    Teacher.find_by(email: params[:session][:email].downcase) || Student.find_by(email: params[:session][:email].downcase)
  end

end
