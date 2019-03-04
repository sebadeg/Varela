class CreateTipoPagos < ActiveRecord::Migration[5.2]
  def change
    create_table :tipo_pagos do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
