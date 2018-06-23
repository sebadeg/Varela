class AddFechaToActividad < ActiveRecord::Migration[5.0]
  def change
    add_column :actividades, :fecha, :date
  end
end
