class CreateEspeciales < ActiveRecord::Migration[5.0]
  def change
    create_table :especiales do |t|
      t.date :fecha_comienzo
      t.date :fecha_fin
      t.string :descripcion
      t.decimal :importe

      t.string :nombre
      t.binary :data
      t.string :md5

      t.boolean :procesado

      t.timestamps
    end
  end
end
