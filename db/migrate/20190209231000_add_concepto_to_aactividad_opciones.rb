class AddConceptoToAactividadOpciones < ActiveRecord::Migration[5.2]
  def change
    add_column :aactividad_opciones, :concepto, :string
  end
end
