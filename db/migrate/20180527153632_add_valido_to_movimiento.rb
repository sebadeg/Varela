class AddValidoToMovimiento < ActiveRecord::Migration[5.0]
  def change
    add_column :movimientos, :valido, :boolean, default: false
  end
end
