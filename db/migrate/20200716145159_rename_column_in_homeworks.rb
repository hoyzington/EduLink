class RenameColumnInHomeworks < ActiveRecord::Migration[6.0]
  def change
    rename_column :homeworks, :done?, :done
  end
end
