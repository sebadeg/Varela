class AddIndiceToPago < ActiveRecord::Migration[5.0]
  def change
  	add_column :pago_cuentas, :indice, :integer
  	add_index :pago_cuentas, [:pago_id,:indice], unique: true
  end

  
end
