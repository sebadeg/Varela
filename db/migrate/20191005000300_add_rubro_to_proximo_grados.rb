class AddRubroToProximoGrados < ActiveRecord::Migration[5.2]
  def change
	add_reference :proximo_grados, :rubro, index: true
    add_foreign_key :proximo_grados, :rubros

    add_column :proximo_grados, :matricula_rubro, :integer
  end
end
