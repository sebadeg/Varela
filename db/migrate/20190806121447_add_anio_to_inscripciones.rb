class AddAnioToInscripciones < ActiveRecord::Migration[5.2]
  def change
    add_column :inscripciones, :reinscripcion, :boolean
  end
end
