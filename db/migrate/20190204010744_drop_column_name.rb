class DropColumnName < ActiveRecord::Migration[5.2]
  def change
    remove_column :inscripcion_alumnos, :fecha_pase
    remove_column :inscripcion_alumnos, :destino
  end
end
