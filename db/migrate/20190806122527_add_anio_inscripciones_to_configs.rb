class AddAnioInscripcionesToConfigs < ActiveRecord::Migration[5.2]
  def change
    add_column :configs, :anio_inscripciones, :integer
  end
end
