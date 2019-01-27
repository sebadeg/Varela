class AddPaseToInscripcionAlumno < ActiveRecord::Migration[5.2]
  def change
    add_column :inscripcion_alumnos, :no_inscribe, :boolean
    add_column :inscripcion_alumnos, :pase, :boolean
  end
end
