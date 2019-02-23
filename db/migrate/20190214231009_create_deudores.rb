class CreateDeudores < ActiveRecord::Migration[5.2]
  def change
    create_table :deudores do |t|
      t.belongs_to :cuenta, foreign_key: true
      t.decimal :deuda360
      t.decimal :deuda180
      t.decimal :deuda90
      t.decimal :deuda60
      t.decimal :deuda30
      t.decimal :deuda0
      t.timestamps
    end
  end
end
