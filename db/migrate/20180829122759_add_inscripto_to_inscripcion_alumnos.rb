class AddInscriptoToInscripcionAlumnos < ActiveRecord::Migration[5.0]
  def change
    add_column :inscripcion_alumnos, :inscripto, :boolean, default: false
  end
end
