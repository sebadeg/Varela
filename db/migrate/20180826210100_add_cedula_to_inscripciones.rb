class AddCedulaToInscripciones < ActiveRecord::Migration[5.0]
  def change
    add_column :inscripciones, :cedula_padre, :integer
    add_column :inscripciones, :cedula_madre, :integer
  end
end
