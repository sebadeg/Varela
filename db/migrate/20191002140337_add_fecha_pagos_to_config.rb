class AddFechaPagosToConfig < ActiveRecord::Migration[5.2]
  def change
    add_column :configs, :fecha_pagos, :date
    add_column :configs, :fecha_descarga, :date
  end
end
