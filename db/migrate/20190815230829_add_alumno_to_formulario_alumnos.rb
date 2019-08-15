class AddAlumnoToFormularioAlumnos < ActiveRecord::Migration[5.2]
  def change
	add_reference :formulario_alumnos, :formulario, index: true
    add_foreign_key :formulario_alumnos, :formularios

    add_column :formulario_alumnos, :cedula, :integer
    remove_column :formulario_alumnos, :formulario
  end
end
