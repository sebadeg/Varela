class AddCedulaToInscripcionAlumno < ActiveRecord::Migration[5.0]
  def change
    add_column :inscripcion_alumnos, :cedula, :integer
  end
end
