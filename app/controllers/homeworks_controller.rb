class HomeworksController < ApplicationController

  before_action :set_homework, only:[:edit, :update, :show, :destroy]
  before_action :set_klass, except:[:destroy]

  def new
    @homework = Homework.new(klass_id: @klass.id)
  end

  def create
    @homework = homework_for_first_student
    if @homework.save
      @student_statuses = @klass.student_statuses.select {|ss| ss.student_id > FIRST_ID}
      homework_for_remaining_students(@student_statuses)
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
    hw = @klass.homeworks_by_student(FIRST_ID)
    @homeworks = hw.select {|h| h.date.day > Time.now.day}
  end

  def index_past
    if user_is_teacher?
      @homeworks = @klass.past_homework_by_student(FIRST_ID)
    else
      @homeworks = @klass.past_homework_by_student(current_user.id)
    end
  end

  def index_late
    @late_homeworks = @klass.homeworks.select {|h| h.done == false}.sort_by {|h| h.date}.reverse
  end

  def show
  end

  def destroy
    @klass = @homework.klass
    if user_is_teacher? && @klass.teacher == current_user
      date = @homework.date.strftime(day_format)
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
    @klass = Klass.find(params[:class_id] || params[:homework][:klass_id] || params[:id])
  end

  def homework_for_first_student
    homework = Homework.new(homework_params)
    homework.student_id = FIRST_ID
    homework.done = true
    homework
  end

  def homework_for_remaining_students(student_statuses)
    student_statuses.each do |s|
      hw = Homework.new(homework_params)
      hw.student_id = s.student_id
      if hw.read == 'None' && hw.exercises == 'None' && hw.other == 'None'
        hw.done = true
      end
      hw.save
    end
  end

end
