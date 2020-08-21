class HomeworksController < ApplicationController

  before_action :require_user, only:[:update, :index_past]
  before_action :require_teacher, except:[:update, :index_past, ]
  before_action :set_homework, only:[:edit, :update, :show, :destroy]
  before_action :set_klass, except:[:destroy]

  def new
    @homework = Homework.new(klass_id: @klass.id)
  end

  def create
    @homework = homework_for_first_student
    if @homework.save
      @student_statuses = @klass.student_statuses.select {|ss| !ss.is_default_or_nonlinked}
      homework_for_remaining_students
      redirect_to klass_homeworks_new_path(@klass)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if user_is_teacher?
      if @homework.update(homework_params)
        update_for_remaining_students
        flash[:notice] = "The homework assignment for #{@homework.formatted_date} has been updated."
        redirect_to klass_future_homeworks_path(@klass)
      else
        render 'edit'
      end
    else
      if @homework.update(homework_params)
        flash[:notice] = "The status of your homework assignment for #{@homework.klass.name} has been updated."
      end
      if @homework.date.today?
        redirect_to student_path(current_user)
      else
        redirect_to klass_past_homeworks_path(@klass)
      end
    end
  end

  def index_future
    hw = @klass.homeworks.by_student(FIRST_ID)
    @homeworks = hw.select {|h| h.future?}
  end

  def index_past
    if user_is_teacher?
      @homeworks = @klass.past_homework_by_student(FIRST_ID)
    else
      @homeworks = @klass.past_homework_by_student(current_user.id)
    end
  end

  def index_late
    @late_homeworks = @klass.homeworks.not_done.sort_by {|h| h.date}.reverse
  end

  def destroy
    @klass = @homework.klass
    if @klass.teacher == current_user
      date = @homework.formatted_date
      @klass.delete_homework(@homework)
      flash[:notice] = "The homework assignment for #{date} has been deleted."
      redirect_to klass_future_homeworks_path(@klass)
    else
      unauthorized
    end
  end

  private

  def homework_params
    params.require(:homework).permit(:date, :read, :exercises, :other, :notes, :done, :klass_id, :student_id)
  end

  def set_homework
    @homework = Homework.find(params[:id])
  end

  def set_klass
    @klass = Klass.find(params[:klass_id] || params[:homework][:klass_id] || params[:id])
  end

  def homework_for_first_student
    homework = Homework.new(homework_params)
    homework.tap do |hw|
      hw.student_id = FIRST_ID
      hw.done = true
    end
  end

  def homework_for_remaining_students
    @student_statuses.each do |s|
      hw = Homework.new(homework_params)
      hw.student_id = s.student_id
      if hw.read == 'None' && hw.exercises == 'None' && hw.other == 'None'
        hw.done = true
      end
      hw.save
    end
  end

  def update_for_remaining_students
    homeworks = @klass.homeworks.select {|h| h.date == @homework.date}
    homeworks.each do |h|
      h.update(homework_params)
    end
  end

end
