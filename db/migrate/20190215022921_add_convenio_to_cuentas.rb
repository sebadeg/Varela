class AddConvenioToCuentas < ActiveRecord::Migration[5.2]
  def change
    add_column :cuentas, :convenio, :string
  end
end
