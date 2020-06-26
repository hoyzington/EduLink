class TeachersController < ApplicationController

  def new
    @object = Teacher.new
  end

  def create
    teacher = Teacher.new(teacher_params)
    if teacher.save
      session[:user_id] = teacher.id
      flash[:notice] = "Welcome to EduLink, #{teacher.first_name}!"
      redirect_to teacher
    else
      render 'new'
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
    if @object.admin?
      flash[:warning] = "This is the Admin account, which can be edited, but not destroyed."
      redirect_to @object
    else
      @object.destroy
      session[:user_id] = nil# if @object == current_object
      flash[:notice] = 'Your EduLink account has been destroyed.'
      redirect_to root_path
    end
  end

  private

  def teacher_params
    params.require(:teacher).permit(:id_number,:first_name, :last_name, :email, :password)
  end

  def set_object
    @object = Teacher.find(params[:id])
  end

end
