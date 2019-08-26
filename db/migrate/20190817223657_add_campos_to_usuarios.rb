class AddCamposToUsuarios < ActiveRecord::Migration[5.2]
  def change
    add_column :usuarios, :lugar_nacimiento, :string
    add_column :usuarios, :fecha_nacimiento, :date
    add_column :usuarios, :profesion, :string
    add_column :usuarios, :trabajo, :string
    add_column :usuarios, :telefono_trabajo, :string
  end
end
