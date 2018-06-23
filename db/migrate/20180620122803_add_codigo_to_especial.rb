class AddCodigoToEspecial < ActiveRecord::Migration[5.0]
  def change
	add_reference :especiales, :codigo, index: true
    add_foreign_key :especiales, :codigos
  end
end
