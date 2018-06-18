class AddArchivoToActividad < ActiveRecord::Migration[5.0]
  def change
    add_column :actividades, :data, :binary
  end
end
