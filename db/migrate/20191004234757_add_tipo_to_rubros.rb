class AddTipoToRubros < ActiveRecord::Migration[5.2]
  def change
	add_reference :rubros, :tipo_rubro, index: true
    add_foreign_key :rubros, :tipo_rubros
  end
end
