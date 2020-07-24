class TeachersController < ApplicationController

  before_action :set_teacher, only:[:show, :edit, :update, :destroy]

  def new
    @teacher = Teacher.new
  end

  def create
    teacher = Teacher.new(teacher_params)
    if teacher.save
      flash[:notice] = "Your profile was created successfully."
      redirect_to teacher_path(teacher)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @teacher.update(teacher_params)
      flash[:notice] = 'Your profile has been updated.'
      redirect_to teacher_path(@teacher)
    else
      render 'edit'
    end
  end

  def index
    if user_is_admin?
      @teachers = Teacher.all.sort_by {|teacher| teacher.last_name}
    else
      flash[:alert] = 'Unauthorized Action'
      redirect_to teacher_path(current_user)
    end
  end

  def show
    @klasses = Klass.by_teacher_by_period(params[:id])
    if user_is_admin?
      check_default_student
    end
  end

  def destroy
    if @teacher.admin?
      flash[:alert] = "This is the Admin account, which can be edited, but not destroyed."
      redirect_to edit_teacher_path(@teacher)
    else
      @teacher.destroy
      if @teacher == current_user
        session[:teacher] = nil
        session[:user_id] = nil
      end
      flash[:notice] = 'The EduLink account has been destroyed.'
      redirect_to root_path
    end
  end

  private

  def teacher_params
    params.require(:teacher).permit(:id_number,:first_name, :last_name, :email, :password)
  end

  def set_teacher
    @teacher = Teacher.find(params[:id])
  end

end
