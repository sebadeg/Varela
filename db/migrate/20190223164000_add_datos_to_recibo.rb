class AddDatosToRecibo < ActiveRecord::Migration[5.2]
  def change
	add_reference :recibos, :lote_recibo, index: true
    add_foreign_key :recibos, :lote_recibos
  end
end
