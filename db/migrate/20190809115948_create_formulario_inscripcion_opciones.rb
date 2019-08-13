class CreateFormularioInscripcionOpciones < ActiveRecord::Migration[5.2]
  def change
    create_table :formulario_inscripcion_opciones do |t|
	  t.belongs_to :formulario, foreign_key: true
	  t.belongs_to :inscripcion_opcion, foreign_key: true

      t.timestamps
    end
  end
end
