class AddFechaExportadoToMovimientos < ActiveRecord::Migration[5.2]
  def change
    add_column :movimientos, :fecha_exportado, :date
  end
end
