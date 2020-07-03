class StudentStatusesController < ApplicationController

  def new
    @student = StudentStatus.new(klass_id: params[:class_id])
    @klass = @student.klass
  end

  def create
    @student = StudentStatus.new(status_params)
    @klass = @student.klass
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
    @klass = Klass.find(params[:class_id])
  end

  def show
  end

  def destroy
  end

  private

  def status_params
    params.require(:student_status).permit(:id_number, :first_name, :last_name, :klass_id)
  end

end
