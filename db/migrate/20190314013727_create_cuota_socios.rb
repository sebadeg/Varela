class CreateCuotaSocios < ActiveRecord::Migration[5.2]
  def change
    create_table :cuota_socios do |t|
      t.belongs_to :socio, foreign_key: true
      t.date :fecha
      t.string :concepto
      t.decimal :importe

      t.timestamps
    end
  end
end
