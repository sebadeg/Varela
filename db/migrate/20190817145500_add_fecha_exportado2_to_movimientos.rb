class AddFechaExportado2ToMovimientos < ActiveRecord::Migration[5.2]
  def change
    add_column :movimientos, :fecha_exportado, :datetime
  end
end
