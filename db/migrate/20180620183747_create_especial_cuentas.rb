class CreateEspecialCuentas < ActiveRecord::Migration[5.0]
  def change
    create_table :especial_cuentas do |t|
      t.belongs_to :especial, foreign_key: true
      t.belongs_to :cuenta, foreign_key: true

      t.timestamps
    end
  end
end
