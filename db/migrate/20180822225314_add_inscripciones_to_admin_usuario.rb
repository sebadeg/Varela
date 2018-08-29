class AddInscripcionesToAdminUsuario < ActiveRecord::Migration[5.0]
  def change
    add_column :admin_usuarios, :inscripciones, :boolean
  end
end
