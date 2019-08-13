class CreateUsuarioSectores < ActiveRecord::Migration[5.2]
  def change
    create_table :usuario_sectores do |t|
      t.belongs_to :admin_usuario, foreign_key: true
      t.belongs_to :sector, foreign_key: true
      t.integer :indice, default: 1

      t.timestamps
    end
  end
end
