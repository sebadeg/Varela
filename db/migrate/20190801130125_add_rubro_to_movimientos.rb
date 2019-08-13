class AddRubroToMovimientos < ActiveRecord::Migration[5.2]
  def change
    add_column :movimientos, :rubro_debe, :integer
    add_column :movimientos, :rubro_haber, :integer
  end
end
