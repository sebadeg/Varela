class AddConceptoToMovimiento < ActiveRecord::Migration[5.0]
  def change
	add_reference :movimientos, :concepto, index: true
    add_foreign_key :movimientos, :conceptos
  end
end
