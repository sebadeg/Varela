class CreateSectores < ActiveRecord::Migration[5.2]
  def change
    create_table :sectores do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
