class AddAdicionalToInscripcion2020 < ActiveRecord::Migration[5.2]
  def change
    add_column :inscripcion2020s, :adicional, :decimal
  end
end
