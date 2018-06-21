class CreateActividadListas < ActiveRecord::Migration[5.0]
  def change
    create_table :actividad_listas do |t|
      t.belongs_to :actividad, foreign_key: true
      t.belongs_to :lista, foreign_key: true

      t.timestamps
    end
  end
end
