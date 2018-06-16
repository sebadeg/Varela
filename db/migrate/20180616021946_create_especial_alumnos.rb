class CreateEspecialAlumnos < ActiveRecord::Migration[5.0]
  def change
    create_table :especial_alumnos do |t|
      t.belongs_to :especial, foreign_key: true
      t.belongs_to :alumno, foreign_key: true

      t.timestamps
    end
  end
end
