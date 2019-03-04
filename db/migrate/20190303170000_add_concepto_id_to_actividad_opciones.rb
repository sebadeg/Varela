class AddConceptoIdToActividadOpciones < ActiveRecord::Migration[5.2]
  def change
	add_reference :actividad_opciones, :opcion_concepto, index: true
    add_foreign_key :actividad_opciones, :opcion_conceptos
  end
end
