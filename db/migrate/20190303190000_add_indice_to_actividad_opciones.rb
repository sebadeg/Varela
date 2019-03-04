class AddIndiceToActividadOpciones < ActiveRecord::Migration[5.2]
  def change
    add_column :actividad_opciones, :indice, :integer
  end
end
