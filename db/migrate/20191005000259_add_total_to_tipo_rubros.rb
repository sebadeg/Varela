class AddTotalToTipoRubros < ActiveRecord::Migration[5.2]
  def change
    add_column :tipo_rubros, :total, :boolean
  end
end
