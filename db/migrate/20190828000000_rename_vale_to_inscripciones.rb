class RenameValeToInscripciones < ActiveRecord::Migration[5.0]
  def change
    rename_column :inscripciones, :vale, :hay_vale
  end
end
