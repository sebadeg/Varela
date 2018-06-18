class AddAdministracionToAdminUsuario < ActiveRecord::Migration[5.0]
  def change
  	add_column :admin_usuarios, :administracion, :boolean, default: false
  end
end
