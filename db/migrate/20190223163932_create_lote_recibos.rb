class CreateLoteRecibos < ActiveRecord::Migration[5.2]
  def change
    create_table :lote_recibos do |t|
      t.belongs_to :cuenta, foreign_key: true
      t.string :nombre
      t.date :fecha
      t.string :suma
      t.string :concepto
      t.integer :hoja_nro

      t.timestamps
    end
  end
end
