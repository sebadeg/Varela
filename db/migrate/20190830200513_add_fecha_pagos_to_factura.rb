class AddFechaPagosToFactura < ActiveRecord::Migration[5.2]
  def change
    add_column :facturas, :fecha_pagos, :date
  end
end
