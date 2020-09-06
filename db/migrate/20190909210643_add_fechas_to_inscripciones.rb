class AddFechasToInscripciones < ActiveRecord::Migration[5.2]
  def change
    add_column :inscripciones, :fecha_registrado, :datetime
    add_column :inscripciones, :fecha_vale, :datetime
    add_column :inscripciones, :fecha_descargado, :datetime
    add_column :inscripciones, :fecha_entregado, :datetime
    add_column :inscripciones, :fecha_inscripto, :datetime
  end
end
