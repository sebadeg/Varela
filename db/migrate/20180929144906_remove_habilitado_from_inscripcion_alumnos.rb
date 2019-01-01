class RemoveHabilitadoFromInscripcionAlumnos < ActiveRecord::Migration[5.2]
  def change
  	remove_column :inscripcion_alumnos, :habilitado
  end
end
