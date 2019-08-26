class ChangesToMovimientos < ActiveRecord::Migration[5.2]
  def change
  	rename_column :movimientos, :rubro_haber, :rubro
  	remove_column :movimientos, :rubro_debe
  end
end
