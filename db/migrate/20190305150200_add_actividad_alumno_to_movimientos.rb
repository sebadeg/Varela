class AddActividadAlumnoToMovimientos < ActiveRecord::Migration[5.2]
  def change
	add_reference :movimientos, :actividad_alumno, index: true
    add_foreign_key :movimientos, :actividad_alumnos
  end
end
