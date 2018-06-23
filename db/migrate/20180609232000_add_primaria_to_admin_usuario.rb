class AddPrimariaToAdminUsuario < ActiveRecord::Migration[5.0]
  def change
  	add_column :admin_usuarios, :primaria, :boolean, default: false
  	add_column :admin_usuarios, :sec_mdeo, :boolean, default: false
  	add_column :admin_usuarios, :sec_cc, :boolean, default: false
  end
end
