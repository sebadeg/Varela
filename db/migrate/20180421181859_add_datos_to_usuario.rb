class AddDatosToUsuario < ActiveRecord::Migration[5.0]
  def change
    add_column :usuarios, :cedula, :integer
    add_column :usuarios, :nombre, :string
    add_column :usuarios, :apellido, :string
    add_column :usuarios, :direccion, :string
    add_column :usuarios, :celular, :string
    add_column :usuarios, :alumno1, :string
    add_column :usuarios, :alumno2, :string
    add_column :usuarios, :alumno3, :string
    add_column :usuarios, :validado, :boolean

    add_index :usuarios, :cedula, unique: true
  end

end
