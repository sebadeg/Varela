class CreateTemps < ActiveRecord::Migration[5.2]
  def change
    create_table :temps do |t|
      t.integer :usuario_id
      t.integer :temp_id

      t.timestamps
    end
  end
end
