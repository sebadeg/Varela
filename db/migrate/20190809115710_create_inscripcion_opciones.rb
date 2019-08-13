class CreateInscripcionOpciones < ActiveRecord::Migration[5.2]
  def change
    create_table :inscripcion_opciones do |t|
      t.string :nombre
      t.integer :anio
      t.belongs_to :inscripcion_opcion_tipo, foreign_key: true
      t.date :fecha
      t.decimal :valor
      t.string :formato

      t.timestamps
    end
  end
end
