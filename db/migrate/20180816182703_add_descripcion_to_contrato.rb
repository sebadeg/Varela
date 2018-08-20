class AddDescripcionToContrato < ActiveRecord::Migration[5.0]
  def change
    add_column :contratos, :descripcion, :string
  end
end
