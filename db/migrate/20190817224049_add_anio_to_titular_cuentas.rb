class AddAnioToTitularCuentas < ActiveRecord::Migration[5.2]
  def change
    add_column :titular_cuentas, :anio, :integer
  end
end
