class AddDatosToMovimientos < ActiveRecord::Migration[5.2]
  def change
    add_column :movimientos, :actividad_alumno_opcion, :integer
  end
end
