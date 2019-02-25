class DropTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :aactividad_opciones
    drop_table :aactividad_alumnos
    drop_table :aactividad_listas
    drop_table :aactividad_archivos
    drop_table :aactividades
  end
end
