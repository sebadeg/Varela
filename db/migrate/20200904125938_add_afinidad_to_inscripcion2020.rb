class AddAfinidadToInscripcion2020 < ActiveRecord::Migration[5.2]
  def change
	add_reference :inscripcion2020s, :afinidad2020, index: true
    add_foreign_key :inscripcion2020s, :afinidad2020s
   	remove_column :inscripcion2020s, :adicional2020_id
  end
end
