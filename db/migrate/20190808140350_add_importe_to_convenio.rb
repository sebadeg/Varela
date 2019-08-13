class AddImporteToConvenio < ActiveRecord::Migration[5.2]
  def change
  	add_column :convenios, :cedula, :integer
    add_column :convenios, :importe, :decimal
    add_column :convenios, :porcentaje, :decimal
    add_column :convenios, :matricula_importe, :decimal
    add_column :convenios, :matricula_porcentaje, :decimal
  end
end
