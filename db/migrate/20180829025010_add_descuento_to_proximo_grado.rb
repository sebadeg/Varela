class AddDescuentoToProximoGrado < ActiveRecord::Migration[5.0]
  def change
    add_column :proximo_grados, :descuento, :decimal
  end
end
