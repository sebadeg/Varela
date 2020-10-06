class AddAnioToInscripcion2020 < ActiveRecord::Migration[5.2]
  def change
    add_column :inscripcion2020s, :anio, :integer
    add_column :inscripcion2020s, :recibida, :string
  end
end
