class CreateConvenio2020s < ActiveRecord::Migration[5.2]
  def change
    create_table :convenio2020s do |t|
      t.string :nombre
      t.decimal :descuento
      t.date :fecha_comienzo
      t.date :fecha_fin

      t.timestamps
    end
  end
end
