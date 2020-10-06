class AddFechoToInscripcion2020 < ActiveRecord::Migration[5.2]
  def change
    add_column :inscripcion2020s, :fecha_ultima, :date
  end
end
