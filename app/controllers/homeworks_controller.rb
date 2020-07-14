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
  end

  def update
  end

  def index_future
    @klass = Klass.find(params[:class_id])
    @homeworks = @klass.homeworks.select {|h| h.date.day > Time.now.day}
    #byebug
  end

  def index_past
    @klass = Klass.find(params[:class_id])
    @homeworks = @klass.homeworks.select {|h| h.date.day < Time.now.day}
  end

  def show
    @homework = Homework.find(params[:id])
    @klass = Klass.find(params[:class_id])
  end

  def destroy
  end

  private

  def homework_params
    params.require(:homework).permit(:date, :read, :exercises, :other, :notes, :klass_id, :student_id)
  end

end
