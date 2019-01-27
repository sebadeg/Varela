class AddComentarioToCuenta < ActiveRecord::Migration[5.2]
  def change
    add_column :cuentas, :comentario, :text
  end
end
