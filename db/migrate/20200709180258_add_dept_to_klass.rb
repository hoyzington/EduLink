class AddDeptToKlass < ActiveRecord::Migration[6.0]
  def change
    add_column :klasses, :dept, :string
  end
end
