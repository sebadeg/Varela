class AddFechaFacturacionToConfigs < ActiveRecord::Migration[5.2]
  def change
    add_column :configs, :fecha_facturacion, :date
  end
end
