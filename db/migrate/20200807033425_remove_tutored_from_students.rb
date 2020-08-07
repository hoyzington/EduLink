class RemoveTutoredFromStudents < ActiveRecord::Migration[6.0]
  def change
    remove_column :students, :tutored?, :boolean
  end
end
