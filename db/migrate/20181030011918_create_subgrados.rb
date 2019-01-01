class CreateSubgrados < ActiveRecord::Migration[5.2]
  def change
    create_table :subgrados do |t|
      t.belongs_to :grado, foreign_key: true
      t.string :nombre
      t.decimal :precio
      t.decimal :descuento
      t.decimal :matricula

      t.timestamps
    end
  end
end
