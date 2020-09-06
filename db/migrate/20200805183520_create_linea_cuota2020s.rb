class CreateLineaCuota2020s < ActiveRecord::Migration[5.2]
  def change
    create_table :linea_cuota2020s do |t|
      t.belongs_to :cuota2020
      t.date :fecha
      t.integer :cantidad
      t.integer :numerador
      t.integer :denominador

      t.timestamps
    end
  end
end
