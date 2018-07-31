class CreateProximoGradoAlumnos < ActiveRecord::Migration[5.0]
  def change
    create_table :proximo_grado_alumnos do |t|
      t.belongs_to :alumno, foreign_key: true
      t.belongs_to :grado, foreign_key: true

      t.timestamps
    end
  end
end
