class CreateCuentas < ActiveRecord::Migration[5.0]
  def change
    create_table :cuentas do |t|

      t.timestamps
    end
  end
end
