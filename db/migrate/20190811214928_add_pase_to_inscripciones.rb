class AddPaseToInscripciones < ActiveRecord::Migration[5.2]
  def change
    add_column :inscripciones, :inhabilitado, :boolean
    add_column :inscripciones, :fecha_pase, :date
    add_column :inscripciones, :destino_pase, :string
  end
end
