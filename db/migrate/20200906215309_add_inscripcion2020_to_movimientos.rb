class AddInscripcion2020ToMovimientos < ActiveRecord::Migration[5.2]
  def change
	add_reference :movimientos, :inscripcion2020, index: true
    add_foreign_key :movimientos, :inscripcion2020s
  end
end
