class AddRetencionToCuentas < ActiveRecord::Migration[5.2]
  def change
    add_column :cuentas, :retencion, :string
  end
end
