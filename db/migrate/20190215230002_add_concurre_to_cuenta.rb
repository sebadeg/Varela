class AddConcurreToCuenta < ActiveRecord::Migration[5.2]
  def change
    add_column :cuentas, :concurre, :boolean
  end
end
