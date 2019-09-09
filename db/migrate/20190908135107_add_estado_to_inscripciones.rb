class AddEstadoToInscripciones < ActiveRecord::Migration[5.2]
  def change
	add_reference :inscripciones, :inscripcion_estado, index: true
    add_foreign_key :inscripciones, :inscripcion_estados
  end
end
