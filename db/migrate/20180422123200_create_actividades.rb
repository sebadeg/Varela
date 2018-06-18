class CreateActividades < ActiveRecord::Migration[5.0]
  def change
    create_table :actividades do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
