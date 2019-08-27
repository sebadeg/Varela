class AddValeToInscripciones < ActiveRecord::Migration[5.2]
  def change
    add_column :inscripciones, :vale, :boolean
  end
end
