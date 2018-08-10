class CreateProximoGrados < ActiveRecord::Migration[5.0]
  def change
    create_table :proximo_grados do |t|
      t.string :nombre
      t.decimal :precio

      t.timestamps
    end
  end
end
