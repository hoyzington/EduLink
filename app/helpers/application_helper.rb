module ApplicationHelper

  def new_klass_link
    link_to "Add A Class", teacher_klasses_new_path(current_user), class: ""
  end

end
