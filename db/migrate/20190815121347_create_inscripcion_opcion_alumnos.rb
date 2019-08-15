class CreateInscripcionOpcionAlumnos < ActiveRecord::Migration[5.2]
  def change
    create_table :inscripcion_opcion_alumnos do |t|
	  t.belongs_to :inscripcion_opcion, foreign_key: true
      t.integer :cedula

      t.timestamps
    end
  end
end
