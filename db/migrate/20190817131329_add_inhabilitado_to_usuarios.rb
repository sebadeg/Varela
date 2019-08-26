class AddInhabilitadoToUsuarios < ActiveRecord::Migration[5.2]
  def change
    add_column :usuarios, :inhabilitado, :boolean
  end
end
