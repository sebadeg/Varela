class AddFormularioToInscripciones < ActiveRecord::Migration[5.2]
  def change
    add_column :inscripciones, :formulario_id, :integer
    add_column :inscripciones, :adicional_id, :integer
    add_column :inscripciones, :hermanos_id, :integer
    add_column :inscripciones, :cuotas_id, :integer
    add_column :inscripciones, :matricula_id, :integer
  end
end
