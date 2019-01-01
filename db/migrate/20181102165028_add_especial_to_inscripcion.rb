class AddEspecialToInscripcion < ActiveRecord::Migration[5.2]
  def change
    add_column :inscripciones, :especial, :string
  end
end
