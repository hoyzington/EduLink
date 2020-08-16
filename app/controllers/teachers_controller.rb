class TeachersController < ApplicationController

  before_action :require_teacher, only:[:edit, :update, :show]
  before_action :require_admin, only:[:index, :destroy]
  before_action :set_teacher, only:[:show, :edit, :update, :destroy]

  def new
    unless user_is_admin?
      clear_session
    end
    @teacher = Teacher.new
  end

  def create
    @teacher = Teacher.new(teacher_params)
    if @teacher.save
      login(@teacher, 'Welcome to EduLink')
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
    @teachers = Teacher.order(:last_name, :first_name)
  end

  def show
    if user_is_admin? || @teacher == current_user
      @klasses = Klass.filtered_by_teacher(@teacher.id)
    else
      unauthorized
    end
  end

  def destroy
    if @teacher.admin?
      flash[:alert] = "This is the Admin account, which can be edited, but not deleted."
      redirect_to teacher_path(@teacher)
    else
      @teacher.destroy
      flash[:notice] =  "#{@teacher.full_name}'s EduLink account has been deleted."
    end
  end

  private

  def teacher_params
    params.require(:teacher).permit(:id_number,:first_name, :last_name, :dept, :email, :password)
  end

  def set_teacher
    @teacher = Teacher.find(params[:id])
  end

  def clear_session
    session.delete :teacher
    session.delete :user_id
  end

end
