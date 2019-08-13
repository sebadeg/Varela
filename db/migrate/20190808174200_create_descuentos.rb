class CreateDescuentos < ActiveRecord::Migration[5.2]
  def change
    create_table :descuentos do |t|
      t.string :nombre
      t.decimal :porcentaje

      t.timestamps
    end
  end
end
