class StudentStatusesController < ApplicationController

  before_action :set_klass, except: [:edit, :update, :destroy]
  before_action :set_student, except: [:new, :create, :index]

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
  end

  def index
    @students = StudentStatus.all
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
    @klass = Klass.find(params[:class_id])
  end

  def status_params
    params.require(:student_status).permit(:id_number, :first_name, :last_name, :klass_id)
  end

end
