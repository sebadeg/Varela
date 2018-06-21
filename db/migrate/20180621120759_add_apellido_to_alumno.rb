class AddApellidoToAlumno < ActiveRecord::Migration[5.0]
  def change
    add_column :alumnos, :apellido, :string
  end
end
