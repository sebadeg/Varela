class AddImporteToMatriculas < ActiveRecord::Migration[5.2]
  def change
    add_column :matriculas, :importe, :decimal
  end
end
