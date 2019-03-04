class AddTipoPagoToPagos < ActiveRecord::Migration[5.2]
  def change
	add_reference :pagos, :tipo_pago, index: true
    add_foreign_key :pagos, :tipo_pagos
  end
end
