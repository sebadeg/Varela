class AddValorEntToInscripcionOpciones < ActiveRecord::Migration[5.2]
  def change
    add_column :inscripcion_opciones, :valor_ent, :integer
  end
end
