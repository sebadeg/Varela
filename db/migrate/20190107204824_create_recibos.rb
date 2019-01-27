class CreateRecibos < ActiveRecord::Migration[5.2]
  def change
    create_table :recibos do |t|
      t.belongs_to :cuenta, foreign_key: true
      t.string :nombre
      t.date :fecha
      t.string :suma
      t.string :concepto
      t.string :cheque
      t.string :banco
      t.date :fecha_vto
      t.decimal :importe
      t.integer :hoja_nro
      
      t.timestamps
    end
  end
end
