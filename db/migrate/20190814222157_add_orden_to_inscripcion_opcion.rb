class AddOrdenToInscripcionOpcion < ActiveRecord::Migration[5.2]
  def change
    add_column :inscripcion_opciones, :orden, :integer
  end
end
