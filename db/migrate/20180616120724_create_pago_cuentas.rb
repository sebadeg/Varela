class CreatePagoCuentas < ActiveRecord::Migration[5.0]
  def change
    create_table :pago_cuentas do |t|
      t.belongs_to :pago, foreign_key: true
      t.belongs_to :cuenta, foreign_key: true

      t.date :fecha
      t.string :descripcion
      t.decimal :importe

      t.timestamps
    end
  end
end
