class AddSectorToProximoGrado < ActiveRecord::Migration[5.2]
  def change
	add_reference :proximo_grados, :sector, index: true
    add_foreign_key :proximo_grados, :sectores
  end
end
