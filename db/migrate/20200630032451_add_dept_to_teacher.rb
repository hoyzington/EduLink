class AddDeptToTeacher < ActiveRecord::Migration[6.0]
  def change
    add_column :teachers, :dept, :string
  end
end
