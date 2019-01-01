class AddFacturadoToInscripcionAlumnos < ActiveRecord::Migration[5.0]
  def change
    add_column :inscripcion_alumnos, :facturado, :date
  end
end
