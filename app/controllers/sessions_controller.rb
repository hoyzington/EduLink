class SessionsController < ApplicationController

  def new
  end

  def create
    user = Teacher.find_by(email: params[:session][:email].downcase) || Student.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      session[:teacher] = "true" if user.class == Teacher
      flash[:notice] = "Welcome back, #{user.first_name}!"
      redirect_to user
    else
      flash.now[:alert] = "There was something wrong with your login details."
      render 'new'
    end
  end

  def destroy
    session[:teacher] = nil
    session[:user_id] = nil
    flash[:notice] = "You have logged out successfully."
    redirect_to root_path
  end
  
end
