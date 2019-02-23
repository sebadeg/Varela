class RemoveDatosFromRecibos < ActiveRecord::Migration[5.0]
  def change
  	remove_column :recibos, :fecha
  	remove_column :recibos, :concepto
  	remove_column :recibos, :suma
  	remove_column :recibos, :cuenta_id
  	remove_column :recibos, :nombre
  	remove_column :recibos, :hoja_nro
  end
end
