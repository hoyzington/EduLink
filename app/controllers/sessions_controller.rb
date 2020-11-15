class SessionsController < ApplicationController

  def new
  end

  def create
    @user = find_teacher_or_student(params[:session])
    if @user && @user.authenticate(params[:session][:password])
      login(@user, 'Welcome back')
    else
      flash[:alert] = "There was something wrong with your login details."
      redirect_to login_path
    end
  end

  def omniauth
    @user = find_teacher_or_student(auth[:info])
    if @user
      login(@user, 'Welcome back')
    else
      @student = Student.new(attributes_from_omniauth)
      session[:oauth] = 'true'
      if StudentStatus.find_by(first_name: @student.first_name, last_name: @student.last_name)
        render 'students/finish_profile'
      else
        redirect_to home_path, alert: 'You are currently not enrolled in any William McKinley High School classes. If you have any questions, please contact the office at 000-000-0000.'
      end
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

  def find_teacher_or_student(hash)
    Teacher.find_by(email: hash[:email].downcase) || Student.find_by(email: hash[:email].downcase)
  end

  def attributes_from_omniauth
    fb_name = auth[:info][:name].split
    {email: auth[:info][:email], first_name: fb_name.first, last_name: (fb_name.last if fb_name.count > 1)}
  end

end
