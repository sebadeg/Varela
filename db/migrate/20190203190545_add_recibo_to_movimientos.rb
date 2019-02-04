class AddReciboToMovimientos < ActiveRecord::Migration[5.2]
  def change
	add_reference :movimientos, :recibo, index: true
    add_foreign_key :movimientos, :recibos
  end
end
