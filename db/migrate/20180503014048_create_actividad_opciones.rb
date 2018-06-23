class CreateActividadOpciones < ActiveRecord::Migration[5.0]
  def change
    create_table :actividad_opciones do |t|
      t.belongs_to :actividad, foreign_key: true
      t.integer :valor
      t.string :opcion
      t.string :eleccion

      t.timestamps
    end
  end
end
