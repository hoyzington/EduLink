class QuizGradesController < ApplicationController

  before_action :set_quiz_grade, only: [:edit, :update]
  before_action :set_klass

  def new
    ss = @klass.student_statuses
    @student_statuses = ss.select {|ss| ss.id_number > FIRST_ID}.sort_by {|s| s.last_name}
    @quiz_num = generate_quiz_num(find_admin_or_first_student(ss))
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
    unless @student_status.klass.teacher == current_user
      unauthorized
    end
  end

  def update
    if @quiz_grade.update(quiz_grade_params)
      flash[:notice] = "The quiz grade was successfully updated."
      redirect_to klass_student_status_path(@klass, @quiz_grade.student_status)
    else
      render 'edit'
    end
  end

  private

  def generate_quiz_num(student_status)
    last_quiz = student_status.quiz_grades.last
    last_quiz ? (last_quiz.number + 1) : 1
  end

  def set_quiz_grade
    @quiz_grade = QuizGrade.find(params[:id])
  end

  def set_klass
    @klass = Klass.find(params[:class_id] || @quiz_grade.student_status.klass.id)
  end

  def quiz_grade_params
    params.require(:quiz_grade).permit(:grade)
  end

end
