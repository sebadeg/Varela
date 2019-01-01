class AddDiaToInscripciones < ActiveRecord::Migration[5.0]
  def change
    add_column :inscripciones, :dia, :integer, default: 10
    add_column :inscripciones, :anio, :integer, default: 2019
  end
end
