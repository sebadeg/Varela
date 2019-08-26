class AddRubroIdToMovimientos < ActiveRecord::Migration[5.2]
  def change
	add_reference :movimientos, :rubro, index: true
    add_foreign_key :movimientos, :rubros
  end
end
