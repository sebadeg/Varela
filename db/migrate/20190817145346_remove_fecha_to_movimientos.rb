class RemoveFechaToMovimientos < ActiveRecord::Migration[5.2]
  def change
  	remove_column :movimientos, :fecha_exportado
  end
end
