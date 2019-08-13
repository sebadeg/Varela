class AddProximoGradoToFormulario < ActiveRecord::Migration[5.2]
  def change
	add_reference :formularios, :proximo_grado, index: true
    add_foreign_key :formularios, :proximo_grados
  end
end
