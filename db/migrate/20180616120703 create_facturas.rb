class CreateFacturas < ActiveRecord::Migration[5.0]
  def change
    create_table :facturas do |t|
      t.belongs_to :cuenta, foreign_key: true
      t.date :fecha
      t.integer :numero
      t.decimal :total

      t.timestamps
    end

    add_index :facturas, [:numero], unique: true
  end
end
