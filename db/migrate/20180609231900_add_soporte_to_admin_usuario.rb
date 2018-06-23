class AddSoporteToAdminUsuario < ActiveRecord::Migration[5.0]
  def change
  	add_column :admin_usuarios, :soporte, :boolean, default: false
  end
end
