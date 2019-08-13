class AddDatosToAlumnos < ActiveRecord::Migration[5.2]
  def change
    add_column :alumnos, :cedula, :integer
    add_column :alumnos, :lugar_nacimiento, :string
    add_column :alumnos, :fecha_nacimiento, :date
    add_column :alumnos, :domicilio, :string
    add_column :alumnos, :celular, :string
    add_column :alumnos, :anio_ingreso, :integer
  end
end
