class CreateFormularios < ActiveRecord::Migration[5.2]
  def change
    create_table :formularios do |t|
      t.string :nombre
      t.integer :cedula

      t.timestamps
    end
  end
end
