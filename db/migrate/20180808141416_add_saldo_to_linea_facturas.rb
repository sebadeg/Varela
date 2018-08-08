class AddSaldoToLineaFacturas < ActiveRecord::Migration[5.0]
  def change
    add_column :linea_facturas, :saldo, :boolean
  end
end
