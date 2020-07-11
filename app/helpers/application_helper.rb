module ApplicationHelper

  def new_klass_link
    link_to "Add A Class", teacher_klasses_new_path(current_user), class: ""
  end

  def homework_when
    Time.now.on_weekend? ? "This Weekend" : "Today (#{Time.now.strftime("%A")})"
  end

end
