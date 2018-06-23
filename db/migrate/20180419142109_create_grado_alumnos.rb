class CreateGradoAlumnos < ActiveRecord::Migration[5.0]
  def change
    create_table :grado_alumnos do |t|
      t.belongs_to :grado, foreign_key: true
      t.belongs_to :alumno, foreign_key: true
      t.integer :anio

      t.timestamps
    end
  end
end
