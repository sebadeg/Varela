class AddGeneralToInscripcionOpcion < ActiveRecord::Migration[5.2]
  def change
    add_column :inscripcion_opciones, :general, :boolean
  end
end
