class AddIndiceToMovimientos < ActiveRecord::Migration[5.2]
  def change
    add_column :movimientos, :indice, :integer
  end
end
