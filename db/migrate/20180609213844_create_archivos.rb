class CreateArchivos < ActiveRecord::Migration[5.0]
  def change
    create_table :archivos do |t|
      t.string :nombre
      t.binary :data
      t.string :md5

      t.timestamps
    end
  end
end
