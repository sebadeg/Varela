class CreateConvenioCuentas < ActiveRecord::Migration[5.0]
  def change
    create_table :convenio_cuentas do |t|
      t.belongs_to :convenio, foreign_key: true
      t.belongs_to :cuenta, foreign_key: true

      t.timestamps
    end
  end
end
