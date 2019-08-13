class AddEspecialIdToMovimientos < ActiveRecord::Migration[5.2]
  def change
	add_reference :movimientos, :especial, index: true
    add_foreign_key :movimientos, :especiales
  end
end
