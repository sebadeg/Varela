class AddIndiceToActividadArchivos < ActiveRecord::Migration[5.2]
  def change
    add_column :actividad_archivos, :indice, :integer
  end
end
