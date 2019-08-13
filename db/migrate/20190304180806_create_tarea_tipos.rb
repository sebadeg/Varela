class CreateTareaTipos < ActiveRecord::Migration[5.2]
  def change
    create_table :tarea_tipos do |t|
      t.integer :nombre

      t.timestamps
    end
  end
end
