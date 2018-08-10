class AddCuotasToActividadOpcion < ActiveRecord::Migration[5.0]
  def change
    add_column :actividad_opciones, :cuotas, :integer
    add_column :actividad_opciones, :importe, :decimal
    add_column :actividad_opciones, :fecha, :date
  end
end
