class AddTareaTipoToTareas < ActiveRecord::Migration[5.2]
  def change
	add_reference :tareas, :tarea_tipo, index: true
    add_foreign_key :tareas, :tarea_tipos
    add_column :tareas, :prioridad, :integer
  end
end
