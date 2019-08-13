class AddCedulaToAlumnos < ActiveRecord::Migration[5.2]
  def change
    add_column :alumnos, :mutualista, :string
    add_column :alumnos, :emergencia, :string
    add_column :alumnos, :procede, :string
    add_reference :alumnos, :cedula_padre, index: true
    add_reference :alumnos, :cedula_madre, index: true
  	add_column :alumnos, :ingreso, :boolean, default: false

  	add_foreign_key :alumnos, :personas, column: :cedula_padre_id
	  add_foreign_key :alumnos, :personas, column: :cedula_madre_id
  end
end
