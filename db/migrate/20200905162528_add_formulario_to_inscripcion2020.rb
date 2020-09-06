class AddFormularioToInscripcion2020 < ActiveRecord::Migration[5.2]
  def change
	add_reference :inscripcion2020s, :formulario2020, index: true
    add_foreign_key :inscripcion2020s, :formulario2020s
  end
end
