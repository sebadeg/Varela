class AddAfinidadToInscripciones < ActiveRecord::Migration[5.0]
  def change
    add_column :inscripciones, :afinidad, :boolean
    add_column :inscripciones, :formulario, :integer
  end
end
