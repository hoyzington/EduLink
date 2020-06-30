class TeachersController < ApplicationController

  before_action :set_user, only:[:show, :edit, :update, :destroy]

  def new
    if user_is_admin?
      @user = Teacher.new
    else
      flash[:alert] = "Unauthorized action"
      redirect_to user_path(current_user)
    end
  end

  def create
    teacher = Teacher.new(teacher_params)
    if teacher.save
      flash[:notice] = "#{teacher.full_name}'s teacher profile was created successfully."
      redirect_to new_teacher_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(teacher_params)
      flash[:notice] = 'Your profile has been updated.'
      redirect_to edit_teacher_path(@user)
    else
      render 'edit'
    end
  end

  def index
    if user_is_admin?
      @teachers = Teacher.all.sort_by {|teacher| teacher[:last_name]}
    else
      flash[:alert] = 'Unauthorized Action'
      redirect_to user_path(current_user)
    end
  end

  def show
    @klasses = Klass.by_teacher_by_period(params[:id])
  end

  def destroy
    if @user.admin?
      flash[:alert] = "This is the Admin account, which can be edited, but not destroyed."
      redirect_to edit_teacher_path(@user)
    else
      @user.destroy
      session[:user_id] = nil# if @user == current_user
      flash[:notice] = 'Your EduLink account has been destroyed.'
      redirect_to root_path
    end
  end

  private

  def teacher_params
    params.require(:teacher).permit(:id_number,:first_name, :last_name, :email, :password)
  end

  def set_user
    @user = Teacher.find(params[:id])
  end

end
