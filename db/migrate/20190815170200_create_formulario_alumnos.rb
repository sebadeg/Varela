class CreateFormularioAlumnos < ActiveRecord::Migration[5.2]
  def change
    create_table :formulario_alumnos do |t|
	  t.belongs_to :formulario, foreign_key: true
      t.integer :cedula

      t.timestamps
    end
  end
end
