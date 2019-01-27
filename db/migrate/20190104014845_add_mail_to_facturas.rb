class AddMailToFacturas < ActiveRecord::Migration[5.2]
  def change
    add_column :facturas, :mail, :boolean, default: false
  end
end
