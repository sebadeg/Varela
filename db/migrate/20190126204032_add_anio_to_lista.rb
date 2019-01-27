class AddAnioToLista < ActiveRecord::Migration[5.2]
  def change
    add_column :listas, :anio, :integer
	add_reference :listas, :sector, index: true
    add_foreign_key :listas, :sectores
  end
end
