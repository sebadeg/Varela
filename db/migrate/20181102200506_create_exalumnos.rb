class CreateExalumnos < ActiveRecord::Migration[5.2]
  def change
    create_table :exalumnos do |t|
      t.string :nombre
      t.string :celular
      t.string :mail
      t.string :padre
      t.string :celular_padre
      t.string :mail_padre
      t.string :madre
      t.string :celular_madre
      t.string :mail_madre
      t.string :pase
      t.string :clase
      t.string :anio_egreso

      t.timestamps
    end
  end
end
