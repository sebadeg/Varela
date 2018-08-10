class AddGradoToInscripcionAlumno < ActiveRecord::Migration[5.0]
  def change
    add_column :inscripcion_alumnos, :grado, :integer
  end
end
