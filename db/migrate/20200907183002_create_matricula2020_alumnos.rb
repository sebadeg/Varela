class CreateMatricula2020Alumnos < ActiveRecord::Migration[5.2]
  def change
    create_table :matricula2020_alumnos do |t|
      t.belongs_to :matricula2020
      t.belongs_to :alumno

      t.timestamps
    end
  end
end
