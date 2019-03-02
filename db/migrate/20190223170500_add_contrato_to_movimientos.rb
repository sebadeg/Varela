class AddContratoToMovimientos < ActiveRecord::Migration[5.2]
  def change
	add_reference :movimientos, :contrato, index: true
    add_foreign_key :movimientos, :contratos
  end
end
