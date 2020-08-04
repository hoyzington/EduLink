class StudentsController < ApplicationController

  before_action :set_student, only:[:show, :edit, :update, :destroy]

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    @student_status = StudentStatus.find_by(id_number: @student.id_number)
    if !@student_status
      
    elsif @student.save
      @student_status.student_id = @student.id
      @student_status.save
      session[:user_id] = @student.id
      flash[:notice] = "Welcome to EduLink, #{@student.first_name}!"
      redirect_to @student
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @student.update(student_params)
      flash[:notice] = 'Your profile has been updated.'
      redirect_to @student
    else
      render 'edit'
    end
  end

  def show
    @student_statuses = @student.student_statuses.sort_by {|ss| ss.klass[:period]}
  end

  def destroy
    if user_is_teacher?
      flash[:alert] = "To delete a student, you must first choose one of your classes, and then choose one of it's students"
      redirect_to teacher_klasses_path(current_user)
    else
      flash[:alert] = "Your EduLink profile will be deleted automatically at the end of the school year or upon withdrawal from school."
      redirect_to @student
    end
  end

  private

  def student_params
    params.require(:student).permit(:id_number,:first_name, :last_name, :email, :password)
  end

  def set_student
    @student = Student.find(params[:id])
  end

end
