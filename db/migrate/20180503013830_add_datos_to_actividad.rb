class AddDatosToActividad < ActiveRecord::Migration[5.0]
  def change
    add_column :actividades, :descripcion, :string
    add_column :actividades, :archivo, :string
  end
end
