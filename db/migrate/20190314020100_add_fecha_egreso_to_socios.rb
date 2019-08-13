class AddFechaEgresoToSocios < ActiveRecord::Migration[5.2]
  def change
    add_column :socios, :fecha_egreso, :date
  end
end
