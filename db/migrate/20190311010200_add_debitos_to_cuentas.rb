class AddDebitosToCuentas < ActiveRecord::Migration[5.2]
  def change
    add_column :cuentas, :visa, :boolean
    add_column :cuentas, :oca, :boolean
  end
end
