class CreateActividadArchivos < ActiveRecord::Migration[5.2]
  def change
    create_table :actividad_archivos do |t|
      t.belongs_to :actividad, foreign_key: true
 	  t.string :nombre
 	  t.binary :data

      t.timestamps
    end
  end
end
