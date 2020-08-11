class SessionsController < ApplicationController

  def new
  end

  def create
    @user = Teacher.find_by(email: params[:session][:email].downcase) || Student.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      session[:teacher] = "true" if @user.class == Teacher
      flash[:notice] = "Welcome back, #{@user.first_name}!"
      redirect_to @user
    else
      flash[:alert] = "There was something wrong with your login details."
      redirect_to login_path
    end
  end

  def destroy
    session.delete :teacher if session[:teacher]
    session.delete :user_id
    redirect_to root_path, notice: "Come back soon!"
  end
  
end
