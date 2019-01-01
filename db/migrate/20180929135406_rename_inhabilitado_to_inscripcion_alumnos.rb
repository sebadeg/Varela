class RenameInhabilitadoToInscripcionAlumnos < ActiveRecord::Migration[5.0]
  def change
    rename_column :inscripcion_alumnos, :inhabilitado, :habilitado
  end
end
