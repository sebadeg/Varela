class AddNombreToCuentas < ActiveRecord::Migration[5.0]
  def change
    add_column :cuentas, :nombre, :string
    add_column :cuentas, :apellido, :string
  end
end
