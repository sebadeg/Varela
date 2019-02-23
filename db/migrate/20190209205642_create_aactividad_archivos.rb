class CreateAactividadArchivos < ActiveRecord::Migration[5.2]
  def change
    create_table :aactividad_archivos do |t|
      t.belongs_to :aactividad, foreign_key: true
      t.string :nombre
      t.binary :data

      t.timestamps
    end
  end
end
