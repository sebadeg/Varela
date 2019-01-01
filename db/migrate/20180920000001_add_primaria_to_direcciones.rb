class AddPrimariaToDirecciones < ActiveRecord::Migration[5.0]
  def change
    add_column :direcciones, :primaria, :boolean, default: false
    add_column :direcciones, :secundaria, :boolean, default: false
    add_column :direcciones, :costa, :boolean, default: false
  end
end
