class AddResultadoToDirecciones < ActiveRecord::Migration[5.0]
  def change
    add_column :direcciones, :resultado, :string
  end
end
