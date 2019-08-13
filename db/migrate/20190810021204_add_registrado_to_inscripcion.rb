class AddRegistradoToInscripcion < ActiveRecord::Migration[5.2]
  def change
    add_column :inscripciones, :registrado, :boolean
    add_column :inscripciones, :inscripto, :boolean
  end
end
