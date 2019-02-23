class AddInfoToCuenta < ActiveRecord::Migration[5.2]
  def change
    add_column :cuentas, :info, :text
  end
end
