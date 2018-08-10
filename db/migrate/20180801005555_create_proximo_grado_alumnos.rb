class CreateProximoGradoAlumnos < ActiveRecord::Migration[5.0]
  def change
    create_table :proximo_grado_alumnos do |t|
      t.belongs_to :alumno, foreign_key: true
      t.integer :grado

      t.timestamps
    end
  end
end
