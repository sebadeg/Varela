class CreateEventoUsuarios < ActiveRecord::Migration[5.0]
  def change
    create_table :evento_usuarios do |t|
      t.string :nombres
      t.string :apellidos
      t.string :telefono
      t.string :celular
      t.string :direccion
      t.date :nacimiento
      t.string :nacionalidad
      t.string :email
      t.string :horarios
      t.boolean :universidad_completa
      t.boolean :universidad_incompleta
      t.string :trabajo
      t.string :ultimo_trabajo
      t.string :comentarios

      t.timestamps
    end
  end
end
