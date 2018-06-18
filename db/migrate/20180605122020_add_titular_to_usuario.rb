class AddTitularToUsuario < ActiveRecord::Migration[5.0]
  def change
    add_column :usuarios, :titular, :boolean
    rename_column :usuarios, :password, :passwd
  end
end
