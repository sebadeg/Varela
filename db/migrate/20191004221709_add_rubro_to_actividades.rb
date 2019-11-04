class AddRubroToActividades < ActiveRecord::Migration[5.2]
  def change
	add_reference :actividades, :rubro, index: true
    add_foreign_key :actividades, :rubros
  end
end
