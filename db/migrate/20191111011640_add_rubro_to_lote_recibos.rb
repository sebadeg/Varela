class AddRubroToLoteRecibos < ActiveRecord::Migration[5.2]
  def change
	add_reference :lote_recibos, :rubro, index: true
    add_foreign_key :lote_recibos, :rubros
  end
end
