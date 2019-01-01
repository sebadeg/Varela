class AddInhabilitadoToInscripcionAlumnos < ActiveRecord::Migration[5.2]
  def change
    add_column :inscripcion_alumnos, :inhabilitado, :boolean
  end
end
