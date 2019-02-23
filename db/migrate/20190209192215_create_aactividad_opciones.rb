class CreateAactividadOpciones < ActiveRecord::Migration[5.2]
  def change
    create_table :aactividad_opciones do |t|
      t.belongs_to :aactividad, foreign_key: true
      t.integer :valor
      t.string :opcion
      t.string :eleccion
      t.integer :cuotas
      t.decimal :importe
      t.date :fecha

      t.timestamps
    end
  end
end
