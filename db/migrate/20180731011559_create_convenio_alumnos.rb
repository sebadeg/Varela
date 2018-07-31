class CreateConvenioAlumnos < ActiveRecord::Migration[5.0]
  def change
    create_table :convenio_alumnos do |t|
      t.integer :alumno
      t.integer :convenio

      t.timestamps
    end
  end
end
