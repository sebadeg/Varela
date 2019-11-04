class AddAnioToMovimientos < ActiveRecord::Migration[5.2]
  def change
    add_column :movimientos, :ejercicio, :integer

	add_reference :movimientos, :inscripcion, index: true
    add_foreign_key :movimientos, :inscripciones
  end
end
