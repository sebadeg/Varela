class CreateCuota2020s < ActiveRecord::Migration[5.2]
  def change
    create_table :cuota2020s do |t|
      t.string :nombre
      t.boolean :formulario
      t.date :fecha_comienzo
      t.date :fecha_fin

      t.timestamps
    end
  end
end
