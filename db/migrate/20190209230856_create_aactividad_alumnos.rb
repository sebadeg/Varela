class CreateAactividadAlumnos < ActiveRecord::Migration[5.2]
  def change
    create_table :aactividad_alumnos do |t|
      t.belongs_to :aactividad, foreign_key: true
      t.belongs_to :alumno, foreign_key: true
      t.integer :opcion
      t.date :fecha
      t.boolean :secretaria
      t.boolean :mail

      t.timestamps
    end
  end
end
