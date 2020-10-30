class StudentStatusesController < ApplicationController

  before_action :require_user, only:[:show]
  before_action :require_teacher, except:[:show]
  before_action :set_student_status, except:[:new, :create, :index, :index_non_edulink]
  before_action :set_klass, except:[:edit, :show, :destroy]
  before_action :set_student_statuses, only:[:new, :create, :index]

  def new
    @student_status = StudentStatus.new(klass_id: @klass.id)
  end

  def create
    @student_status = StudentStatus.new(status_params)
    @student_status.link_with_student
    if @student_status.save
      flash[:notice] = "#{@student_status.full_name} was added successfully."
      redirect_to klass_student_statuses_new_path(@student_status.klass)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @student_status.update(status_params)
      flash[:notice] = "#{@student_status.full_name}'s profile was successfully updated."
      redirect_to klass_student_status_path(@klass, @student_status)
    else
      render 'edit'
    end
  end

  def index
  end

  def index_non_edulink
    @student_statuses = @klass.student_statuses.not_on_edulink
  end

  def show
    @klass = @student_status.klass
    @homeworks = @student_status.late_homeworks(@klass).sort_by {|h| h.date}.reverse
    @quiz_grades = @student_status.quiz_grades
  end

  def destroy
    if @student_status.is_default
      flash[:alert] = "This default student profile must remain as long as your class exists."
      redirect_to current_user
    else
      @student_status.delete_homework
      @student_status.quiz_grades.clear
      @student_status.destroy
      flash[:notice] = "#{@student_status.full_name} has been removed from your class in EduLink."
      redirect_to current_user
    end
  end

  private

  def set_student_status
    @student_status = StudentStatus.find(params[:id])
  end

  def set_student_statuses
    @student_statuses = @klass.student_statuses.list || []
  end

  def set_klass
    @klass = Klass.find(params[:klass_id] || params[:student_status][:klass_id]) || @student_status.klass
  end

  def status_params
    params.require(:student_status).permit(:id_number, :first_name, :last_name, :klass_id)
  end

end
