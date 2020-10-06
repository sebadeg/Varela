class AddindiceInscripcion2020 < ActiveRecord::Migration[5.2]
  def change
	add_column :movimientos, :inscripcion2020_indice, :integer
  end
end
