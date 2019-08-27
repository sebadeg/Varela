class AddPrecioAnteriorToInscripciones < ActiveRecord::Migration[5.2]
  def change
    add_column :inscripciones, :precio_anterior, :decimal
  end
end
