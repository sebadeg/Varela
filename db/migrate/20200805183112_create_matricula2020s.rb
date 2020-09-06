class CreateMatricula2020s < ActiveRecord::Migration[5.2]
  def change
    create_table :matricula2020s do |t|
      t.string :nombre
      t.boolean :formulario
      t.decimal :precio
      t.date :fecha_comienzo
      t.date :fecha_fin

      t.timestamps
    end
  end
end
