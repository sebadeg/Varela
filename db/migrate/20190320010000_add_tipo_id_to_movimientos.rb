class AddTipoIdToMovimientos < ActiveRecord::Migration[5.2]
  def change
	add_reference :movimientos, :tipo_movimiento, index: true
    add_foreign_key :movimientos, :tipo_movimientos
  end
end
