class AddAlumnoToInscripciones < ActiveRecord::Migration[5.2]
  def change
    add_column :inscripciones, :cuenta_id, :integer
    add_column :inscripciones, :alumno_id, :integer
  end
end
