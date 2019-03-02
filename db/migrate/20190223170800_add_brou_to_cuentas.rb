class AddBrouToCuentas < ActiveRecord::Migration[5.2]
  def change
    add_column :cuentas, :brou, :boolean
  end
end
