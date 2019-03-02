class AddDatosToActividadAlumnos < ActiveRecord::Migration[5.2]
  def change
    add_column :actividad_alumnos, :opcion_secretaria, :integer
    add_column :actividad_alumnos, :fecha_secretaria, :date
  end
end
