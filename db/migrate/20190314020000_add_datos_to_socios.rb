class AddDatosToSocios < ActiveRecord::Migration[5.2]
  def change
    add_column :socios, :apellido, :string
    add_column :socios, :fecha_ingreso, :date
    add_column :socios, :telefono, :string
  end
end
