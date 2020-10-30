class StudentsController < ApplicationController

  before_action :require_user, only:[:show, :destroy]
  before_action :require_admin, only:[:index]
  before_action :require_student, only:[:edit, :update]
  before_action :set_student, only:[:show, :edit, :update, :destroy]

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    @student.password = SecureRandom.hex if oauth?
    @student_status = StudentStatus.find_by(id_number: @student.id_number)
    if !@student_status
      @student.errors[:student] << 'ID number is invalid'
      choose_form
    elsif @student.save
      @student_status.student = @student
      @student_status.save
      login(@student, 'Welcome to EduLink')
    else
      choose_form
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

  def index
    @students = Student.order(:last_name, :first_name).select {|s| !s.is_default}
  end

  def destroy
    if user_is_teacher?
      if user_is_admin?
        @student.destroy
        flash[:notice] = 'Student was successfully deleted from EduLink'
        redirect_to students_path
      else
        flash[:alert] = "To delete a student, you must first choose one of your classes, and then choose one of it's students"
        redirect_to teacher_klasses_path(current_user)
      end
    else
      flash[:alert] = "Your EduLink profile will be deleted automatically after graduation or upon withdrawal from school."
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
