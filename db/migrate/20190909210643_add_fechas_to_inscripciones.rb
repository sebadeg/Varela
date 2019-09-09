class AddFechasToInscripciones < ActiveRecord::Migration[5.2]
  def change
    add_column :inscripciones, :fecha_registrado, :date
    add_column :inscripciones, :fecha_vale, :date
    add_column :inscripciones, :fecha_descargado, :date
    add_column :inscripciones, :fecha_entregado, :date
    add_column :inscripciones, :fecha_inscripto, :date
    remove_column :inscripciones, :inscripcion_estado_id
    drop_table :inscripcion_estados
  end
end
