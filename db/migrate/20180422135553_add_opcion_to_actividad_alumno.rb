class AddOpcionToActividadAlumno < ActiveRecord::Migration[5.0]
  def change
    add_column :actividad_alumnos, :opcion, :integer
  end
end
