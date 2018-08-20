class CreateContratoCuotas < ActiveRecord::Migration[5.0]
  def change
    create_table :contrato_cuotas do |t|
      t.belongs_to :contrato, foreign_key: true
      t.date :fecha
      t.decimal :precio
      t.decimal :descuento

      t.timestamps
    end
  end
end
