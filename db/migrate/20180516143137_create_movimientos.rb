class CreateMovimientos < ActiveRecord::Migration[5.0]
  def change
    create_table :movimientos do |t|
      t.belongs_to :cuenta, foreign_key: true      
      t.integer :alumno
      t.date :fecha
      t.string :descripcion
      t.string :extra
      t.decimal :debe
      t.decimal :haber
      t.integer :tipo

      t.timestamps
    end

    add_index :movimientos, [:cuenta_id,:fecha]
  end
end
