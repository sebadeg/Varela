class AddSecretariaToAdminUsuarios < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_usuarios, :secretaria, :boolean
  end
end
