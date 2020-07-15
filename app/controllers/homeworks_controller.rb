class HomeworksController < ApplicationController

  def new
    @klass = Klass.find(params[:class_id])
    @homework = Homework.new(klass_id: @klass.id)
  end

  def create
    @klass = Klass.find(params[:homework][:klass_id])
    statuses = @klass.student_statuses.select {|s| s.student_id > 0}
    statuses.each do |s|
      homework = Homework.new(homework_params)
      homework.student_id = s.student.id
      homework.save
    end
    redirect_to klass_homeworks_new_path(@klass)
  end

  def edit
    @klass = Klass.find(params[:class_id])
    @homework = Homework.find(params[:id])
  end

  def update
  end

  def index_future
    @klass = Klass.find(params[:class_id])
    homework_index_for_teacher
  end

  def index_past
    @klass = Klass.find(params[:class_id])
    if user_is_teacher?
      homework_index_for_teacher
    else
      @homeworks = current_user.homeworks.select {|h| h.date.day < Time.now.day}
    end
  end

  def show
    @homework = Homework.find(params[:id])
    @klass = Klass.find(params[:class_id])
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

  def homework_index_for_teacher
    homeworks = @klass.homeworks.select {|h| h.student_id == 0}
    @homeworks = homeworks.select {|h| h.date.day > Time.now.day}
  end

end
