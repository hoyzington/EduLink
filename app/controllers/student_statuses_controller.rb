class StudentStatusesController < ApplicationController

  before_action :set_student, except: [:new, :create, :index]
  before_action :set_klass, except: [:edit, :destroy]

  def new
    @student = StudentStatus.new(klass_id: params[:class_id])
  end

  def create
    @student = StudentStatus.new(status_params)
    if @student.save
      flash[:notice] = "#{@student.full_name} was added successfully."
      redirect_to klass_student_statuses_new_path(@klass)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @student.update(status_params)
      flash[:notice] = "#{@student.full_name}'s profile was successfully updated."
      redirect_to klass_student_status_path(@klass, @student)
    else
      render 'edit'
    end
  end

  def index
    @students = @klass.student_statuses
  end

  def show
  end

  def destroy
  end

  private

  def set_student
    @student = StudentStatus.find(params[:id])
  end

  def set_klass
    @klass = Klass.find(params[:class_id] || @student.klass_id)
  end

  def status_params
    params.require(:student_status).permit(:id_number, :first_name, :last_name, :klass_id)
  end

end
