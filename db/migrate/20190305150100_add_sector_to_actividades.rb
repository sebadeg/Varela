class AddSectorToActividades < ActiveRecord::Migration[5.2]
  def change
	add_reference :actividades, :sector, index: true
    add_foreign_key :actividades, :sectores
  end
end
