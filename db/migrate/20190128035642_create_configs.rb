class CreateConfigs < ActiveRecord::Migration[5.2]
  def change
    create_table :configs do |t|
      t.integer :anio

      t.timestamps
    end
  end
end
