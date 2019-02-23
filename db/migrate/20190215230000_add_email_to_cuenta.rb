class AddEmailToCuenta < ActiveRecord::Migration[5.2]
  def change
    add_column :cuentas, :cedula, :integer
    add_column :cuentas, :direccion, :string
    add_column :cuentas, :celular, :string
    add_column :cuentas, :email, :string
  end
end
