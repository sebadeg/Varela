class CreateTareas < ActiveRecord::Migration[5.0]
  def change
    create_table :tareas do |t|
      t.string :descripcion
      t.boolean :realizada

      t.timestamps
    end
  end
end
