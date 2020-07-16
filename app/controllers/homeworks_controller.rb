class HomeworksController < ApplicationController

  before_action :set_klass, except:[:create, :destroy]
  before_action :set_homework, only:[:edit, :update, :show]

  def new
    @homework = Homework.new(klass_id: @klass.id)
  end

  def create
    klass = Klass.find(params[:homework][:klass_id])
    klass.homework_for_each_student(homework_params)
    redirect_to klass_homeworks_new_path(klass)
  end

  def edit
  end

  # def update
  #   if @homework.update(homework_params)
  #     flash[:notice] = "The homework assignment for #{@homework.date.strftime("%A, %m/%d/%y ")} has been updated."
  #     redirect_to klass_future_homeworks_path(@klass)
  #   else
  #     render 'edit'
  #   end
  # end

  def index_future
    homework_index_for_teacher
  end

  def index_past
    if user_is_teacher?
      homework_index_for_teacher
    else
      @homeworks = current_user.homeworks.select {|h| h.date.day < Time.now.day}
    end
  end

  def show
  end

  def destroy
    if user_is_admin?
      Homework.all.each {|h| h.delete}
      flash[:notice] = 'All homework assignments for all classes for the semester have been deleted.'
    else
      flash[:alert] = 'Unauthorized Action'
    end
    redirect_to home_path
  end

  private

  def homework_params
    params.require(:homework).permit(:date, :read, :exercises, :other, :notes, :klass_id, :student_id)
  end

  def set_klass
    @klass = Klass.find(params[:class_id])
  end

  def set_homework
    @homework = Homework.find(params[:id])
  end

  def homework_index_for_teacher
    homeworks = @klass.homeworks.select {|h| h.student_id == 0}
    @homeworks = homeworks.select {|h| h.date.day > Time.now.day}
  end

end
