class StudentStatusesController < ApplicationController

  def new
    @student_status = StudentStatus.new(klass_id: params[:class_id])
    @klass = @student_status.klass
  end

  def create
    @student_status = StudentStatus.new(status_params)
    @klass = @student_status.klass
    if @student_status.save
      flash[:notice] = "#{@student_status.full_name} was added successfully."
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
