class CreatePases < ActiveRecord::Migration[5.2]
  def change
    create_table :pases do |t|
      t.belongs_to :alumno, foreign_key: true
      t.date :fecha_pase
      t.text :destino

      t.timestamps
    end
  end
end
