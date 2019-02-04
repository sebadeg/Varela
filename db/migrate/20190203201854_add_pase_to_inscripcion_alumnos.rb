class AddPaseToInscripcionAlumnos < ActiveRecord::Migration[5.2]
  def change
    add_column :inscripcion_alumnos, :fecha_pase, :date
    add_column :inscripcion_alumnos, :destino, :string
  end
end
