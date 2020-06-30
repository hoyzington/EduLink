class StudentStatusesController < ApplicationController

  def new
    @status = StudentStatus.new(klass_id: params[:klass_id])
  end

  def create
    @status = StudentStatus.new(status_params)
    if @status.save
      flash[:notice] = "#{@status.name} was added successfully."
      redirect_to klass_statuses_new_path(current_user)
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

end
