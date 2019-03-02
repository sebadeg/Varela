class AddBajadoToFacturas < ActiveRecord::Migration[5.2]
  def change
    add_column :facturas, :bajado, :datetime
  end
end
