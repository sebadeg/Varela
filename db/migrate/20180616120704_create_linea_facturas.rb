class CreateLineaFacturas < ActiveRecord::Migration[5.0]
  def change
    create_table :linea_facturas do |t|
      t.belongs_to :factura, foreign_key: true
      t.belongs_to :alumno, foreign_key: true
      t.string :nombre_alumno
      t.integer :indice
      t.string :descripcion
      t.decimal :importe

      t.timestamps
    end

    add_index :linea_facturas, [:factura_id,:indice], unique: true
  end
end
