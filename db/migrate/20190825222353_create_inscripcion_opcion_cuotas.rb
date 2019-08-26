class CreateInscripcionOpcionCuotas < ActiveRecord::Migration[5.2]
  def change
    create_table :inscripcion_opcion_cuotas do |t|
	  t.belongs_to :inscripcion_opcion, foreign_key: true
      t.date :fecha
      t.integer :cantidad
      t.decimal :importe

      t.timestamps
    end
  end
end
