class AddDatosToContratos < ActiveRecord::Migration[5.2]
  def change
    add_column :contratos, :cuotas, :integer
    add_column :contratos, :aguinaldos, :boolean
    add_column :contratos, :comienzo, :date
    add_column :contratos, :importe, :decimal
  end
end
