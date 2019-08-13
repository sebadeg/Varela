class ChangeNombreTypeInTareaTipos < ActiveRecord::Migration[5.2]
  def change
  	change_column :tarea_tipos, :nombre, :string
  end
end
