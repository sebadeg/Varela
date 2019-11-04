class RemoveFechasToInscripciones < ActiveRecord::Migration[5.2]
  def change
    remove_column :inscripciones, :fecha_registrado
    remove_column :inscripciones, :fecha_vale
    remove_column :inscripciones, :fecha_descargado
    remove_column :inscripciones, :fecha_entregado
    remove_column :inscripciones, :fecha_inscripto
    add_column :inscripciones, :fecha_registrado, :datetime
    add_column :inscripciones, :fecha_vale, :datetime
    add_column :inscripciones, :fecha_descargado, :datetime
    add_column :inscripciones, :fecha_entregado, :datetime
    add_column :inscripciones, :fecha_inscripto, :datetime
  end
end
