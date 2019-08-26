class RemoveRubroFromMovimientos < ActiveRecord::Migration[5.2]
  def change
   	remove_column :movimientos, :rubro
 end
end
