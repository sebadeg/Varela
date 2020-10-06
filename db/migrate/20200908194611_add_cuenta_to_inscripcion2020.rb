class AddCuentaToInscripcion2020 < ActiveRecord::Migration[5.2]
  def change
	add_reference :inscripcion2020s, :cuenta, index: true
    add_foreign_key :inscripcion2020s, :cuentas
    add_column :inscripcion2020s, :nuevo_alumno_id, :integer
  end
end
