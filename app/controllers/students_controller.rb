class StudentsController < ApplicationController

  def new
    @object = Student.new
  end

  def create
    student = Student.new(student_params)
    status = StudentStatus.find_by(id_number: student.id_number)
    if status.nil?
      flash[:warning] = "Invalid student ID number. Please try again."
      render 'new'
    elsif status.student
      flash[:warning] = "Another student has created an account with this ID number. Please try again or contact your teacher."
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
    if @object.update(object_params)
      flash[:notice] = 'Your profile has been updated.'
      redirect_to @object
    else
      render 'edit'
    end
  end

  def show
  end

  def destroy
    @object.destroy
    session[:user_id] = nil# if @object == current_object
    flash[:notice] = 'Your EduLink account has been destroyed; however, all your school records are still intact.'
    redirect_to root_path
  end

  private

  def student_params
    params.require(:student).permit(:id_number,:first_name, :last_name, :email, :password)
  end

  def set_object
    @object = Student.find(params[:id])
  end

end
