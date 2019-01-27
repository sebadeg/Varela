class AddIndexMailToFacturas < ActiveRecord::Migration[5.2]
  def change
  	add_index :facturas, [:mail]
  end
end
