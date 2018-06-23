class AddPendienteToMovimientos < ActiveRecord::Migration[5.0]
  def change
    add_column :movimientos, :pendiente, :boolean, default: true
    add_index :movimientos, :pendiente
  end
end
