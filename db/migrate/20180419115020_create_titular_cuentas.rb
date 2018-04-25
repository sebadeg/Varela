class CreateTitularCuentas < ActiveRecord::Migration[5.0]
  def change
    create_table :titular_cuentas do |t|
      t.belongs_to :usuario, foreign_key: true
      t.belongs_to :cuenta, foreign_key: true

      t.timestamps
    end
  end
end
