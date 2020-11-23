class QuizGradesController < ApplicationController

  before_action :require_teacher
  before_action :set_quiz_grade, only: [:edit, :update]
  before_action :set_klass, except: [:update]

  def new
    @student_statuses = @klass.student_statuses.list
    @quiz_num = generate_quiz_num
  end

  def create
    success = true
    @klass.student_statuses.each do |ss|
      qg = QuizGrade.new
      qg.number = params[:quiz_num]
      qg.grade = params["#{ss.id_number}"] || 0
      qg.student_status_id = ss.id
      if !qg.save
        success = false
      end
    end
    if success == true
      flash[:notice] = 'The new quiz grades were entered successfully.'
      redirect_to teacher_klass_path(current_user, @klass)
    else
      render 'new'
    end
  end

  def edit
    @student_status = @quiz_grade.student_status
    unauthorized unless @student_status.klass.teacher == current_user
  end

  def update
    @klass = @quiz_grade.student_status.klass
    if @quiz_grade.update(quiz_grade_params)
      flash[:notice] = "The quiz grade was successfully updated."
      redirect_to klass_student_status_path(@klass, @quiz_grade.student_status)
    else
      render 'edit'
    end
  end

  private

  def set_quiz_grade
    @quiz_grade = QuizGrade.find(params[:id])
  end

  def set_klass
    @klass = Klass.find(params[:klass_id])
  end

  def quiz_grade_params
    params.require(:quiz_grade).permit(:grade)
  end

  def generate_quiz_num
    ss = find_admin_or_first_student(@klass.student_statuses)
    last_quiz = ss.quiz_grades.last
    last_quiz ? (last_quiz.number + 1) : 1
  end

  def find_admin_or_first_student(array)
    array.detect {|x| x.is_default}
  end

end
