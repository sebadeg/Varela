class AddCamposInscripcion < ActiveRecord::Migration[5.2]
  def change
  	add_column :inscripciones, :apellido1, :string
  	add_column :inscripciones, :apellido2, :string
  end
end
