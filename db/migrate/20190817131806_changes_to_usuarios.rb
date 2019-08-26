class ChangesToUsuarios < ActiveRecord::Migration[5.2]
  def change
  	rename_column :usuarios, :inhabilitado, :habilitado
  end
end
