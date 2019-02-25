class RemoveBajadoFromActividadAlumnos < ActiveRecord::Migration[5.0]
  def change
  	remove_column :actividad_alumnos, :bajado
  end
end
