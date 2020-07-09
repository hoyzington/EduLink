class HomeworksController < ApplicationController

  def new
    @klass = Klass.find(params[:class_id])
    @homework = Homework.new(klass_id: @klass.id)
  end

  def create
    @klass = Klass.find(params[:homework][:klass_id])
    @klass.student_statuses.each do |ss|
      homework = Homework.new(homework_params)
      homework.student_id = ss.student.id
      homework.save
    end
    redirect_to klass_homework_path(@klass, @klass.homeworks.last)
  end

  def edit
  end

  def update
  end

  def index
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
