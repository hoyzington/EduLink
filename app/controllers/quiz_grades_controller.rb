class QuizGradesController < ApplicationController

  def new
    @klass = Klass.find(params[:class_id])
    ss = @klass.student_statuses
    @student_statuses = ss.select {|ss| ss.id_number > 0}.sort_by {|s| s.last_name}
    @quiz_num = generate_quiz_num(ss.first)
  end

  def create
    @klass = Klass.find(params[:klass_id])
    success = true
    @klass.student_statuses.each do |ss|
      qg = QuizGrade.new
      qg.number = params[:quiz_num]
      qg.grade = params["#{ss.id_number}"]
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
  end

  def update
  end

  private

  def generate_quiz_num(student_status)
    last_quiz = student_status.quiz_grades.last
    last_quiz ? (last_quiz.number + 1) : 1
  end

end
