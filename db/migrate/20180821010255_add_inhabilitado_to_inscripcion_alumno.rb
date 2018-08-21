class AddInhabilitadoToInscripcionAlumno < ActiveRecord::Migration[5.0]
  def change
    add_column :inscripcion_alumnos, :inhabilitado, :boolean
  end
end
