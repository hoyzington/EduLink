class KlassesController < ApplicationController

  before_action :set_klass, only: [:edit, :update, :show, :destroy]
  before_action :set_klasses_or_student_statuses, only: [:new, :create, :index]

  def new
    if user_is_teacher?
      @klass = Klass.new(teacher_id: current_user.id)
    else
      unauthorized
    end
  end

  def create
    @klass = Klass.new(klass_params)
    @klass.dept = current_user.dept
    if @klass.save
      @klass.create_first_student_status
      flash[:notice] = "#{@klass.name} was added successfully."
      redirect_to teacher_klasses_new_path(current_user)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @klass.update(klass_params)
      flash[:notice] = "#{@klass.name} was successfully updated."
      redirect_to teacher_klass_path(current_user, @klass)
    else
      render 'edit'
    end
  end

  def index
  end

  def show
    @homework = @klass.current_homework(FIRST_ID)
    @student_statuses = @klass.student_statuses
    @late_students = @klass.students.select {|s| s.homeworks.detect {|h| h.done == false}}
    @non_edulink_students = @klass.non_edulink_students
  end

  def destroy
    if user_is_admin?
      @klass.destroy
      flash[:notice] = "The EduLink data for #{@klass.name}, Period #{@klass.period} has been deleted."
      redirect_to teacher_klasses_path(current_user)
    else
      unauthorized
    end
  end

  def year_end
  end

  def destroy_data
    if user_is_admin?
      # QuizGrade.destroy_all
      # Homework.destroy_all
      # StudentStatus.all.each {|ss| ss.destroy unless ss.id_number == FIRST_ID}
      flash[:notice] = 'The End Of Year Proceedure was performed.'
      redirect_to current_user
    else
      unauthorized
    end
  end

private

  def klass_params
    params.require(:klass).permit(:name, :period, :teacher_id)
  end

  def set_klass
    @klass = Klass.find(params[:id])
  end

  def set_klasses_or_student_statuses
    if user_is_teacher?
      @klasses = current_user.klasses.sort_by {|k| k[:period]}
    else
      @student_statuses = current_user.student_statuses.sort_by {|ss| ss.klass[:period]}
    end
  end

end
