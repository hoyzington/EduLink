class KlassesController < ApplicationController

  before_action :set_klass, only: [:edit, :update, :show, :destroy]
  before_action :set_klasses, only: [:new, :index]

  def new
    @klass = Klass.new(teacher_id: params[:teacher_id])
  end

  def create
    @klass = Klass.new(klass_params)
    if @klass.save
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
  end

  def destroy
  end

private

  def klass_params
    params.require(:klass).permit(:name, :period, :teacher_id)
  end

  def set_klass
    @klass = Klass.find(params[:id])
  end

  def set_klasses
    @klasses = Klass.by_teacher_by_period(params[:teacher_id])
  end
end
