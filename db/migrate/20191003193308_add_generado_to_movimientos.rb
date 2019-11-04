class AddGeneradoToMovimientos < ActiveRecord::Migration[5.2]
  def change
    add_column :movimientos, :generado, :boolean
  end
end
