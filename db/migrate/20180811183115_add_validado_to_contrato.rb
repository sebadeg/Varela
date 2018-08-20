class AddValidadoToContrato < ActiveRecord::Migration[5.0]
  def change
    add_column :contratos, :validado, :boolean
  end
end
