class CreatePagos < ActiveRecord::Migration[5.0]
  def change
    create_table :pagos do |t|
      t.string :nombre
      t.binary :data
      t.string :md5

      t.boolean :procesado
      
      t.timestamps
    end
  end
end
