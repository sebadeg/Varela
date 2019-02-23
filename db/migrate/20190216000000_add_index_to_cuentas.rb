class AddIndexToCuentas < ActiveRecord::Migration[5.2]
  def change
  	add_index :cuentas, [:nombre]
  end
end
