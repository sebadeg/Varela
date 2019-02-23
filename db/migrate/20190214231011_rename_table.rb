class RenameTable < ActiveRecord::Migration[5.2]
  def change
    rename_table :deudas, :movimiento2018s 
  end
end
