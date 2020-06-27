class StudentsController < ApplicationController

  before_action :set_user, only:[:show, :edit, :update, :destroy]

  def new
    @user = Student.new
  end

  def create
    student = Student.new(student_params)
    status = StudentStatus.find_by(id_number: student.id_number)
    if status.nil?
      flash[:alert] = "Invalid student ID number. Please try again."
      render 'new'
    elsif status.student
      flash[:alert] = "Another student has created an account with this ID number. Please try again or contact your teacher."
      render 'new'
    else
      student.student_status = status
      if student.save
        session[:user_id] = student.id
        flash[:notice] = "Welcome to EduLink, #{student.first_name}!"
        redirect_to student
      else
        render 'new'
      end
    end

  end

  def edit
  end

  def update
    if @user.update(student_params)
      flash[:notice] = 'Your profile has been updated.'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def show
  end

  def destroy
    @user.destroy
    session[:user_id] = nil# if @user == current_user
    flash[:notice] = 'Your EduLink account has been destroyed; however, all your school records are still intact.'
    redirect_to root_path
  end

  private

  def student_params
    params.require(:student).permit(:id_number,:first_name, :last_name, :email, :password)
  end

  def set_user
    @user = Student.find(params[:id])
  end

end
