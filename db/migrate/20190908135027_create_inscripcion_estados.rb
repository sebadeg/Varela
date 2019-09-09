class CreateInscripcionEstados < ActiveRecord::Migration[5.2]
  def change
    create_table :inscripcion_estados do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
