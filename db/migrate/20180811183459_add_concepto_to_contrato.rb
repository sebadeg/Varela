class AddConceptoToContrato < ActiveRecord::Migration[5.0]
  def change
	add_reference :contratos, :concepto, index: true
    add_foreign_key :contratos, :conceptos
  end
end
