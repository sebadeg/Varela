class RemoveNumeroFromFacturas < ActiveRecord::Migration[5.0]
  def change
  	remove_column :facturas, :numero
  end
end
