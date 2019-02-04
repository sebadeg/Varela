class AddFacturaToUsuarios < ActiveRecord::Migration[5.2]
  def change
    add_column :usuarios, :factura, :boolean
  end
end
