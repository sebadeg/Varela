class CreateContratos < ActiveRecord::Migration[5.0]
  def change
    create_table :contratos do |t|
      t.belongs_to :cuenta, foreign_key: true
      t.integer :anio

      t.timestamps
    end
  end
end
