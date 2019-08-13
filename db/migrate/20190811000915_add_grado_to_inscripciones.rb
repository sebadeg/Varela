class AddGradoToInscripciones < ActiveRecord::Migration[5.2]
  def change
	add_reference :inscripciones, :grado, index: true
    add_foreign_key :inscripciones, :grados
  end
end
