class CreateDirecciones < ActiveRecord::Migration[5.2]
  def change
    create_table :direcciones do |t|
      t.belongs_to :usuario, foreign_key: true
      t.string :direccion
      t.decimal :latitude
      t.decimal :longitude

      t.timestamps
    end
  end
end
