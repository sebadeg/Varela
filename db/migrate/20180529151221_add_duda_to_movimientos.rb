class AddDudaToMovimientos < ActiveRecord::Migration[5.0]
  def change
    add_column :movimientos, :duda, :boolean, default: false
  end
end
