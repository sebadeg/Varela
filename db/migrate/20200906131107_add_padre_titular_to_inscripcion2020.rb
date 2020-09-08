class AddPadreTitularToInscripcion2020 < ActiveRecord::Migration[5.2]
  def change
    add_column :inscripcion2020s, :padre_titular, :boolean
    add_column :inscripcion2020s, :madre_titular, :boolean
    add_column :inscripcion2020s, :congelado, :decimal
  end
end
