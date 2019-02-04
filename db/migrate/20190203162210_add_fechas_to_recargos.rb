class AddFechasToRecargos < ActiveRecord::Migration[5.2]
  def change
    add_column :recargos, :fecha_comienzo, :date
    add_column :recargos, :fecha_fin, :date
  end
end
