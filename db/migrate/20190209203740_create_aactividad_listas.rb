class CreateAactividadListas < ActiveRecord::Migration[5.2]
  def change
    create_table :aactividad_listas do |t|
      t.belongs_to :aactividad, foreign_key: true
      t.belongs_to :lista, foreign_key: true

      t.timestamps
    end
  end
end
