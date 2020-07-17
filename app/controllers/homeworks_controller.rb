class HomeworksController < ApplicationController

  before_action :set_klass, except:[:create, :update, :destroy]
  before_action :set_homework, only:[:edit, :update, :show]

  def new
    @homework = Homework.new(klass_id: @klass.id)
  end

  def create
    @klass = Klass.find(params[:homework][:klass_id])
    @klass.new_homework_for_each_student(homework_params)
    redirect_to klass_homeworks_new_path(@klass)
  end

  def edit
  end

  def update
    @klass = @homework.klass
    if user_is_teacher?
      if @homework.update(homework_params)
        homeworks = @klass.homeworks.select {|h| h.date == @homework.date}
        homeworks.each do |h|
          h.update(homework_params)
        end
        flash[:notice] = "The homework assignment for #{@homework.date.strftime("%A, %m/%d/%y ")} has been updated."
        redirect_to klass_future_homeworks_path(@klass)
      else
        render 'edit'
      end
    else
      if @homework.update(homework_params)
        flash[:notice] = "The status of your current homework assignment for #{@homework.klass.name} has been updated."
      end
      if @homework.date.day == Time.now.day
        redirect_to student_path(current_user)
      else
        redirect_to klass_past_homeworks_path(@klass)
      end
    end
  end

  def index_future
    # uses the default student's id
    hw = @klass.homeworks_by_student(0)
    @homeworks = hw.select {|h| h.date.day > Time.now.day}
  end

  def index_past
    if user_is_teacher?
      # uses the default student's id
      @homeworks = @klass.past_homework_by_student(0)
    else
      @homeworks = @klass.past_homework_by_student(current_user.id)
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
    params.require(:homework).permit(:date, :read, :exercises, :other, :notes, :done, :klass_id, :student_id)
  end

  def set_klass
    @klass = Klass.find(params[:class_id])
  end

  def set_homework
    @homework = Homework.find(params[:id])
  end

end
