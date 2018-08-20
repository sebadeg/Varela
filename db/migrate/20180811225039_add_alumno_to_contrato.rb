class AddAlumnoToContrato < ActiveRecord::Migration[5.0]
  def change
	add_reference :contratos, :alumno, index: true
    add_foreign_key :contratos, :alumnos
  end
end
