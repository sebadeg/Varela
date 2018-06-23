class CreateCuentaAlumnos < ActiveRecord::Migration[5.0]
  def change
    create_table :cuenta_alumnos do |t|
      t.belongs_to :cuenta, foreign_key: true
      t.belongs_to :alumno, foreign_key: true
      t.integer :numero

      t.timestamps
    end
  end
end
