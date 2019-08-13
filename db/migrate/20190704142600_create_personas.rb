class CreatePersonas < ActiveRecord::Migration[5.2]
  def change
    create_table :personas do |t|
      t.string :nombre
      t.string :apellido
      t.string :lugar_nacimiento
      t.date :fecha_nacimiento
      t.string :email
      t.string :domicilio
      t.string :celular
      t.string :profesion
      t.string :trabajo
      t.string :telefono_trabajo

      t.timestamps
    end
  end
end
