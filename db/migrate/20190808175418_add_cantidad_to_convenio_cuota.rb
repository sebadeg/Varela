class AddCantidadToConvenioCuota < ActiveRecord::Migration[5.2]
  def change
    add_column :convenio_cuota, :cantidad, :integer
  end
end
