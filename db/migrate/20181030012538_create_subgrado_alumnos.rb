class CreateSubgradoAlumnos < ActiveRecord::Migration[5.2]
  def change
    create_table :subgrado_alumnos do |t|
      t.belongs_to :subgrado, foreign_key: true
      t.belongs_to :alumno, foreign_key: true

      t.timestamps
    end
  end
end
