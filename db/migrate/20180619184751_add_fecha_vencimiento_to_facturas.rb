class AddFechaV	toToFacturas < ActiveRecord::Migration[5.0]
  def change
    add_column :facturas, :fecha_vencimiento, :date
  end
end
