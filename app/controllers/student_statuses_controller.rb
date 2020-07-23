class StudentStatusesController < ApplicationController

  before_action :set_student_status, except: [:new, :create, :index]
  before_action :set_klass, except: [:create, :edit]

  def new
    @student_status = StudentStatus.new(klass_id: params[:class_id])
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
    @student_statuses = @klass.student_statuses.select {|ss| ss.id_number > 0}
  end

  def show
  end

  def destroy
    @student_status.destroy unless @student_status.id_number == 0
    flash[:notice] = 'The student has been removed from this class.'
    redirect_to klass_students_path(@klass)
  end

  private

  def set_student_status
    @student_status = StudentStatus.find(params[:id])
  end

  def set_klass
    @klass = Klass.find(params[:class_id] || params[:klass_id] || @student_status.klass_id)
  end

  def status_params
    params.require(:student_status).permit(:id_number, :first_name, :last_name, :klass_id)
  end

end
