class AddSaldoToMovimientos < ActiveRecord::Migration[5.2]
  def change
    add_column :movimientos, :saldo, :decimal
  end
end
