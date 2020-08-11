class TeachersController < ApplicationController

  before_action :require_teacher, except:[:index, :destroy]
  before_action :require_admin, only:[:index, :destroy]
  before_action :set_teacher, only:[:show, :edit, :update, :destroy]

  def new
    if !user_is_admin?
      session[:teacher] = nil
      session[:user_id] = nil
      @teacher = Teacher.new
    else
      @teacher = Teacher.new
    end
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
      unauthorized
    end
  end

  def show
    if user_is_admin? || @teacher == current_user
      @klasses = Klass.by_teacher_by_period(params[:id])
    else
      unauthorized
    end
  end

  def destroy
    if user_is_admin?
      if @teacher.admin?
        flash[:alert] = "This is the Admin account, which can be edited, but not deleted."
        redirect_to teacher_path(@teacher)
      else
        @teacher.destroy
        flash[:notice] =  "#{@teacher.full_name}'s EduLink account has been deleted."
      end
    else
      unauthorized
    end
  end

  private

  def teacher_params
    params.require(:teacher).permit(:id_number,:first_name, :last_name, :dept, :email, :password)
  end

  def set_teacher
    @teacher = Teacher.find(params[:id])
  end

end
