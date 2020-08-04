class StudentStatusesController < ApplicationController

  before_action :set_student_status, except: [:new, :create, :index, :index_non_edulink]
  before_action :set_klass, except: [:edit]

  def new
    @student_status = StudentStatus.new(klass_id: params[:class_id])
    @student_statuses = @klass.student_statuses || []
  end

  def create
    @student_status = StudentStatus.new(status_params)
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
    @student_statuses = @klass.student_statuses.select {|ss| ss.id_number > 0}.sort_by {|student| student.last_name}
  end

  def index_non_edulink
    @student_statuses = @klass.non_edulink_students.sort_by {|s| s[:last_name]}
  end

  def show
    @late_homework = @student_status.late_homework(@klass.id).sort_by {|h| h.date}.reverse
    @quiz_grades = @student_status.quiz_grades
  end

  def destroy
    if user_is_teacher? && @klass.teacher == current_user
      if @student_status.id_number == FIRST_ID
        flash[:alert] = "This default student profile must remain as long as #{@klass.name} exists."
        redirect_to klass_student_statuses_path(@klass)
      else
        @student_status.delete_homework
        @student_status.delete_quiz_grades
        @student_status.destroy
        flash[:notice] = "#{@student_status.full_name} has been removed from #{@klass.name} in EduLink."
        redirect_to klass_student_statuses_path(@klass)
      end
    else
      unauthorized
    end
  end

  private

  def set_student_status
    @student_status = StudentStatus.find(params[:id])
  end

  def set_klass
    if user_is_teacher?
      @klass = Klass.find(params[:class_id] || params[:klass_id] || params[:student_status][:klass_id])
    else
      @klass = Klass.find(@student_status.klass_id)
    end
  end

  def status_params
    params.require(:student_status).permit(:id_number, :first_name, :last_name, :klass_id)
  end

end
