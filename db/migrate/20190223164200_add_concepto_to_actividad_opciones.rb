class AddConceptoToActividadOpciones < ActiveRecord::Migration[5.2]
  def change
    add_column :actividad_opciones, :concepto, :string

  end
end
