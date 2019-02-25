class AddFechaToActividadAlumnos < ActiveRecord::Migration[5.2]
  def change
    add_column :actividad_alumnos, :fecha, :date
    add_column :actividad_alumnos, :secretaria, :boolean
    add_column :actividad_alumnos, :mail, :boolean
  end
end
