class AddOcultarPorcentajeToConvenio < ActiveRecord::Migration[5.0]
  def change
    add_column :convenios, :ocultar_porcentaje, :boolean
  end
end
