class CreateSectorAlumnos < ActiveRecord::Migration[5.2]
  def change
    create_table :sector_alumnos do |t|
      t.belongs_to :alumno, foreign_key: true
      t.belongs_to :sector, foreign_key: true
      t.integer :anio

      t.timestamps
    end
  end
end
