module TeachersHelper

  def delete_teacher_button
    link_to "Delete Profile", teacher_path, method: :delete, data: {confirm: "Are you sure?"}
  end

end
