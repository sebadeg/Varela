class AddSueToAdminUsuario < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_usuarios, :sue, :boolean
  end
end
