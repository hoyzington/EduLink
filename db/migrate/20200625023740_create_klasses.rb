class CreateKlasses < ActiveRecord::Migration[6.0]
  def change
    create_table :klasses do |t|
      t.string :name
      t.string :period
      t.belongs_to :teacher, null: false, foreign_key: true

      t.timestamps
    end
  end
end
