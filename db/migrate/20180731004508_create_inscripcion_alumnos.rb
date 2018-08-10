class CreateInscripcionAlumnos < ActiveRecord::Migration[5.0]
  def change
    create_table :inscripcion_alumnos do |t|
      t.belongs_to :alumno, foreign_key: true
      t.belongs_to :grado, foreign_key: true
      t.belongs_to :convenio, foreign_key: true

      t.integer :hermanos
      t.integer :cuotas
      t.integer :mes

      t.string :nombre1
      t.integer :documento1
      t.string :domicilio1
      t.string :email1
      t.string :celular1

      t.string :nombre2
      t.integer :documento2
      t.string :domicilio2
      t.string :email2
      t.string :celular2

      t.boolean :registrado

      t.timestamps
    end
  end
end
