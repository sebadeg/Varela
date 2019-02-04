class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :pases, :fecha_pase, :fecha
  end
end
