class AddMatriculaToInscripcionAlumno < ActiveRecord::Migration[5.0]
  def change
    add_column :inscripcion_alumnos, :matricula, :integer
    add_column :inscripcion_alumnos, :visa, :boolean
  end
end
