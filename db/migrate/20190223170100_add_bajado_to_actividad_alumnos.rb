class AddBajadoToActividadAlumnos < ActiveRecord::Migration[5.2]
  def change
    add_column :actividad_alumnos, :bajado, :date
  end
end
