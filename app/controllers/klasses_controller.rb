class KlassesController < ApplicationController

  before_action :require_teacher, except:[:index, :destroy, :year_end, :destroy_data]
  before_action :require_admin, only:[:destroy, :year_end, :destroy_data]
  before_action :set_klass, only: [:edit, :update, :show, :destroy]
  before_action :set_klasses_or_student_statuses, only: [:new, :create, :index]

  def new
    @klass = Klass.new(teacher_id: current_user.id)
  end

  def create
    @klass = Klass.new(klass_params)
    @klass.dept = current_user.dept
    if @klass.save
      create_first_student_status(@klass)
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
    @homework = @klass.homeworks.current(FIRST_ID)
    @student_statuses = @klass.student_statuses
    @late_students = students_with_late_homework
    @nonlinked = @klass.student_statuses.not_on_edulink
  end

  def destroy
    @klass.destroy
    flash[:notice] = "The EduLink data for #{@klass.name}, Period #{@klass.period} has been deleted."
    redirect_to teacher_klasses_path(@klass.teacher)
  end

  def year_end
  end

  def destroy_data
    # QuizGrade.destroy_all
    # Homework.destroy_all
    # StudentStatus.all.each {|ss| ss.destroy unless ss.is_default}
    flash[:notice] = 'The End Of Year Proceedure was performed.'
    redirect_to current_user
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
      @klasses = current_user.klasses.order(:period)
    else
      @student_statuses = current_user.student_statuses.sort_by {|ss| ss.klass[:period]}
    end
  end

  def create_first_student_status(klass)
    s = Student.find_by(id_number: FIRST_ID)
    klass.student_statuses.create(id_number: s.id_number, first_name: s.first_name, last_name: s.last_name, student_id: s.id)
  end

  def students_with_late_homework
    late_homeworks = @klass.homeworks.not_done
    late_homeworks.map {|h| h.student.id_number}.uniq
  end

end
