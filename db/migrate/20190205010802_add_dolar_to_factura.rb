class AddDolarToFactura < ActiveRecord::Migration[5.2]
  def change
    add_column :facturas, :dolar, :decimal
  end
end
