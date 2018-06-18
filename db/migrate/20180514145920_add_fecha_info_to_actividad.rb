class AddFechaInfoToActividad < ActiveRecord::Migration[5.0]
  def change
    add_column :actividades, :fechainfo, :date
  end
end
