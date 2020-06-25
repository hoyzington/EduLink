class CreateHomeworks < ActiveRecord::Migration[6.0]
  def change
    create_table :homeworks do |t|
      t.string :read, default: "None"
      t.string :exercises, default: "None"
      t.text :other, default: "None"
      t.text :notes, default: "None"
      t.date :date
      t.boolean :done?, default: false
      t.belongs_to :klass, null: false, foreign_key: true
      t.belongs_to :student, null: true, foreign_key: true

      t.timestamps
    end
  end
end
